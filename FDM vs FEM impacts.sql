-- how different are the overall impacts of 12 months of FDMs and associated FEMs?
CREATE MATERIALIZED VIEW fdm24_mv AS(
    SELECT
        DISTINCT fdm.assessment_id AS assessment_id,
        fdm.account_id,
        fdm.raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' AS facility_types,
        fdm.raw -> 'results' -> 'answers' -> 'reportingmonth' ->> 'response' AS reporting_month,
        fdm.raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year,
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
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantrawMaterialProcessing' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantrawMaterialProcessing' ->> 'response')::numeric
        END AS rawMaterialProcessing_prodvol,
        CASE 
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantrawMaterialCollection' ->> 'response')::numeric
            WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantrawMaterialCollection' ->> 'response')::numeric
        END AS rawMaterialCollection_prodvol,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_mj')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_mj')::numeric
        END AS finalProductAssembly_mj,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'printingProductDyeingAndLaundering_mj')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'printingProductDyeingAndLaundering_mj')::numeric
        END AS printingProductDyeingAndLaundering_mj,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'hardComponentTrimProduction_mj')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'hardComponentTrimProduction_mj')::numeric
        END AS hardComponentTrimProduction_mj,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'materialProduction_mj')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'materialProduction_mj')::numeric
        END AS materialProduction_mj,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'rawMaterialProcessing_mj')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'rawMaterialProcessing_mj')::numeric
        END AS rawMaterialProcessing_mj,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'rawMaterialCollection_mj')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'rawMaterialCollection_mj')::numeric
        END AS rawMaterialCollection_mj,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_total_kgco2e')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_total_kgco2e')::numeric
        END AS finalProductAssembly_total_kgco2e,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'printingProductDyeingAndLaundering_total_kgco2e')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'printingProductDyeingAndLaundering_total_kgco2e')::numeric
        END AS printingProductDyeingAndLaundering_total_kgco2e,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'hardComponentTrimProduction_total_kgco2e')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'hardComponentTrimProduction_total_kgco2e')::numeric
        END AS hardComponentTrimProduction_total_kgco2e,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'materialProduction_total_kgco2e')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'materialProduction_total_kgco2e')::numeric
        END AS materialProduction_total_kgco2e,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'rawMaterialProcessing_total_kgco2e')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'rawMaterialProcessing_total_kgco2e')::numeric
        END AS rawMaterialProcessing_total_kgco2e,
        CASE 
            WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
                THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'rawMaterialCollection_total_kgco2e')::numeric
            ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'rawMaterialCollection_total_kgco2e')::numeric
        END AS rawMaterialCollection_total_kgco2e
        -- fdm.raw
    FROM 
        public.dct AS fdm
    WHERE
        (fdm.raw ->> 'facilityPosted')::boolean = TRUE
        AND fdm.raw ->> 'status' NOT ILIKE '%ASD%'
        AND fdm.raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' LIKE '2024'
)

with fdm24_agg AS (
    SELECT
        COUNT(DISTINCT fdm24_mv.assessment_id) AS count_fdm24,
        fdm24_mv.account_id,
        SUM(finalProductAssembly_prodvol) AS total_finalProductAssembly_prodvol,
        SUM(printingProductDyeingAndLaundering_prodvol) AS total_printingProductDyeingAndLaundering_prodvol,
        SUM(hardComponentTrimProduction_prodvol) AS total_hardComponentTrimProduction_prodvol,
        SUM(materialProduction_prodvol) AS total_materialProduction_prodvol,
        SUM(rawMaterialProcessing_prodvol) AS total_rawMaterialProcessing_prodvol,
        SUM(rawMaterialCollection_prodvol) AS total_rawMaterialCollection_prodvol,
        SUM(finalProductAssembly_mj) AS total_finalProductAssembly_mj,
        SUM(printingProductDyeingAndLaundering_mj) AS total_printingProductDyeingAndLaundering_mj,
        SUM(hardComponentTrimProduction_mj) AS total_hardComponentTrimProduction_mj,
        SUM(materialProduction_mj) AS total_materialProduction_mj,
        SUM(rawMaterialProcessing_mj) AS total_rawMaterialProcessing_mj,
        SUM(rawMaterialCollection_mj) AS total_rawMaterialCollection_mj,
        SUM(finalProductAssembly_total_kgco2e) AS total_finalProductAssembly_total_kgco2e,
        SUM(printingProductDyeingAndLaundering_total_kgco2e) AS total_printingProductDyeingAndLaundering_total_kgco2e,
        SUM(hardComponentTrimProduction_total_kgco2e) AS total_hardComponentTrimProduction_total_kgco2e,
        SUM(materialProduction_total_kgco2e) AS total_materialProduction_total_kgco2e,
        SUM(rawMaterialProcessing_total_kgco2e) AS total_rawMaterialProcessing_total_kgco2e,
        SUM(rawMaterialCollection_total_kgco2e) AS total_rawMaterialCollection_total_kgco2e
    FROM fdm24_mv
    GROUP BY fdm24_mv.account_id
)

SELECT
    COUNT(DISTINCT fdm24_agg.account_id) AS count_accounts
FROM fdm24_agg
WHERE count_fdm24 >= 12