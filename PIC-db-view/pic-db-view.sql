DROP TABLE IF EXISTS public.pic_fem_linking_eligibility;

CREATE TABLE public.pic_fem_linking_eligibility AS

WITH eligibility AS (
    SELECT
        a.account_id AS supplier_account_id,
        a.active,
        CASE WHEN a.active <> 'true'
            THEN 'Not eligible' ELSE 'Eligible'
        END AS active_eligibility,
        a.name AS supplier_name,
        a.sac_id AS supplier_worldly_id,
        fem.assessment_id,
        fem.rfi_pid,
        fem.status,
        CASE 
            WHEN fem.status IN ('ASI', 'NS', 'ASD') THEN 'Not eligible'
            ELSE 'Eligible'
        END AS status_eligibility,
        facility_types.facility_type, -- Extracted facility types as a comma-separated string
        CASE
			WHEN
			    (  
				facility_types.facility_type LIKE '%Finished Product Assembler%' OR
				facility_types.facility_type LIKE '%Finished Product Processing%' OR
				facility_types.facility_type LIKE '%Final Product Assembly%' OR
				facility_types.facility_type LIKE '%Printing, Product Dyeing and Laundering%'
			    )
				THEN 'Eligible' ELSE 'Not eligible'
		END AS tier_eligibility,
        CASE
            WHEN fem.rfi_pid IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            THEN fem.performance ->> 'sipfacilityannualprodvolquant'
            ELSE 'Check facility type specific production volume quantity'
        END AS overall_prod_vol_quant,
        CASE
            WHEN fem.rfi_pid IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            THEN fem.performance ->> 'sipfacilityannualprodvolunits'
            ELSE 'Check facility type specific production volume unit'
        END AS overall_prod_vol_unit,
        CASE
            WHEN fem.rfi_pid NOT IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            THEN fem.performance ->> 'finalProductAssemblytotal'
            ELSE 'Check overall production volume quantity and unit'
        END AS finalProductAssembly_prod_vol_pcspair,
        CASE
            WHEN fem.rfi_pid NOT IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            THEN fem.performance ->> 'printingProductDyeingAndLaunderingtotal'
            ELSE 'Check overall production volume quantity and unit'
        END AS printingProductDyeingAndLaundering_prod_vol_kg,
        CASE
            WHEN ((fem.rfi_pid IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            AND (CAST(fem.performance ->> 'sipfacilityannualprodvolquant' AS NUMERIC)>0))
            OR (fem.rfi_pid NOT IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
                AND ((CAST(fem.performance ->> 'finalProductAssemblytotal' AS NUMERIC)>0)
                OR (CAST(fem.performance ->> 'printingProductDyeingAndLaunderingtotal' AS NUMERIC)>0))))
            THEN 'Eligible' ELSE 'Not eligible'
        END AS prod_vol_eligibility,
		CASE 
			WHEN fem.performance ->> 'sipfacilityannualprodvolunits' IN ('Square Yard', 'Meter', 'Cubic Meters', 'SAM')
			THEN 'Not eligible' ELSE 'Eligible'
		END AS prod_unit_eligibility,
        fem.performance ->> 'ensourcetrackopt' AS tracking_any_energy,
        CASE WHEN (fem.performance ->> 'ensourcetrackopt' <> 'Yes' OR fem.performance ->> 'ensourcetrackopt' IS NULL)
            THEN 'Not eligible' ELSE 'Eligible'
        END AS energy_eligibility,
        CASE
            WHEN fem.rfi_pid IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            THEN fem.performance ->> 'totalNormalizedGHGemissions'
            ELSE 'Check facility type specific normalized emissions'
        END AS overall_normalized_emissions,
        CASE
            WHEN fem.rfi_pid NOT IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            THEN fem.performance ->> 'finalProductAssembly_normalizedghg'
            ELSE 'Check overall facility normalized emissions'
        END AS finalProductAssembly_normalized_emissions,
        CASE
            WHEN fem.rfi_pid NOT IN ('fem2022', 'fem2021', 'fem2020', 'fem201')
            THEN fem.performance ->> 'printingProductDyeingAndLaundering_normalizedghg'
            ELSE 'Check overall facility normalized emissions'
        END AS printingProductDyeingAndLaundering_normalized_emissions,
        (
            SELECT STRING_AGG(s.account_id::TEXT, ', ')
            FROM public.fem_shares AS s
            WHERE
				s.assessment_id = fem.assessment_id
				AND s.share_status = 'accepted'
        ) AS brands_shared_with
    FROM public.fem_simple AS fem
    INNER JOIN public.account AS a
        ON fem.account_id = a.account_id
    INNER JOIN LATERAL (
        -- Unnest the JSON array and then aggregate into a string
        SELECT STRING_AGG(value, ', ') AS facility_type
        FROM jsonb_array_elements_text(fem.performance -> 'sipfacilitytype') AS value
    ) AS facility_types ON true
)

SELECT *,
    CASE
        WHEN active_eligibility = 'Eligible' 
        AND status_eligibility = 'Eligible' 
        AND tier_eligibility = 'Eligible'
        AND prod_vol_eligibility = 'Eligible'
        AND prod_unit_eligibility = 'Eligible'
        AND energy_eligibility = 'Eligible'
        THEN 'Eligible'
        ELSE
            -- Concatenate all reasons and remove the trailing comma
            REGEXP_REPLACE(
                'Not eligible based on ' || 
                CASE WHEN active_eligibility <> 'Eligible' THEN 'Active eligibility, ' ELSE '' END ||
                CASE WHEN status_eligibility <> 'Eligible' THEN 'Status eligibility, ' ELSE '' END ||
                CASE WHEN tier_eligibility <> 'Eligible' THEN 'Tier eligibility, ' ELSE '' END ||
                CASE WHEN prod_vol_eligibility <> 'Eligible' THEN 'Production volume eligibility, ' ELSE '' END ||
                CASE WHEN prod_unit_eligibility <> 'Eligible' THEN 'Production unit eligibility, ' ELSE '' END ||
                CASE WHEN energy_eligibility <> 'Eligible' THEN 'Energy eligibility, ' ELSE '' END,
                ',\s*$',  -- Regex to match the trailing comma and optional spaces
                ''
            )
    END AS final_eligibility
FROM eligibility;