-- how different are the overall impacts of 12 months of FDMs and associated FEMs?
with fdm24 AS (
    SELECT
        DISTINCT fdm.assessment_id AS assessment_id,
        fdm.account_id,
        fdm.raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' AS facility_types,
        fdm.raw -> 'results' -> 'answers' -> 'reportingmonth' ->> 'response' AS reporting_month,
        fdm.raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year,
        -- CASE 
        --     WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
        --         THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric
        --     ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric
        -- END AS finalProductAssembly_normalized_mj,
        -- CASE 
        --     WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
        --         THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'printingProductDyeingAndLaundering_normalized_mj')::numeric
        --     ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'printingProductDyeingAndLaundering_normalized_mj')::numeric
        -- END AS printingProductDyeingAndLaundering_normalized_mj,
        ---
        CASE 
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfinalProductAssembly' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantfinalProductAssembly' ->> 'response')::numeric
        END AS finalProductAssembly_prodvol,
        CASE 
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantprintingProductDyeingAndLaundering' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantprintingProductDyeingAndLaundering' ->> 'response')::numeric
        END AS printingProductDyeingAndLaundering_prodvol,
        CASE 
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquanthardComponentTrimProduction' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquanthardComponentTrimProduction' ->> 'response')::numeric
        END AS hardComponentTrimProduction_prodvol,
        CASE 
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantmaterialProduction' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantmaterialProduction' ->> 'response')::numeric
        END AS materialProduction_prodvol,
        CASE 
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfdm.rawMaterialProcessing' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantfdm.rawMaterialProcessing' ->> 'response')::numeric
        END AS fdm.rawMaterialProcessing_prodvol,
        CASE 
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfdm.rawMaterialCollection' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantfdm.rawMaterialCollection' ->> 'response')::numeric
        END AS fdm.rawMaterialCollection_prodvol,
        -- fdm.raw
    FROM 
        public.dct AS fdm
    LEFT JOIN public.fem_simple AS fem
        ON fdm.account_id = fem.account_id
    WHERE
        (fdm.raw ->> 'facilityPosted')::boolean = TRUE
        AND fdm.raw ->> 'status' NOT ILIKE '%ASD%'
        AND fdm.raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' LIKE '2024'
    GROUP BY 2,3
    LIMIT 1000
)