with cte AS(
    SELECT
        account_id,
        raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' AS facility_types,
        CASE 
            WHEN raw ->> 'status' ILIKE '%VRF%'
                THEN (raw -> 'results' -> 'verifierCalculations' ->> 'materialProduction_normalized_mj')::numeric
            ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'materialProduction_normalized_mj')::numeric
        END AS materialProduction_normalized_mj,
        CASE 
            WHEN raw ->> 'status' ILIKE '%VRF%'
                THEN (raw -> 'results' -> 'verifierCalculations' ->> 'rawMaterialProcessing_normalized_mj')::numeric
            ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'rawMaterialProcessing_normalized_mj')::numeric
        END AS rawMaterialProcessing_normalized_mj,
        CASE 
            WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantmaterialProduction' ->> 'response')::numeric
            WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantmaterialProduction' ->> 'response')::numeric
        END AS materialProduction_prodvol,
        CASE 
            WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantrawMaterialProcessing' ->> 'response')::numeric
            WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantrawMaterialProcessing' ->> 'response')::numeric
        END AS rawMaterialProcessing_prodvol,
        CASE 
            WHEN (
                raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%materialProduction%'
                AND 
                CASE 
                    WHEN raw ->> 'status' ILIKE '%VRF%'
                        THEN (raw -> 'results' -> 'verifierCalculations' ->> 'materialProduction_normalized_mj')::numeric > 0
                    ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'materialProduction_normalized_mj')::numeric > 0
                END
                AND 
                CASE 
                    WHEN raw ->> 'status' ILIKE '%VRF%' THEN
                        CASE 
                            WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantmaterialProduction' ->> 'corrected')::numeric > 0
                            WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantmaterialProduction' ->> 'corrected')::numeric > 0
                        END
                    ELSE
                        CASE 
                            WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantmaterialProduction' ->> 'response')::numeric > 0
                            WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantmaterialProduction' ->> 'response')::numeric > 0
                        END
                END
            ) THEN TRUE

            WHEN (
                raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%rawMaterialProcessing%'
                AND 
                CASE 
                    WHEN raw ->> 'status' ILIKE '%VRF%'
                        THEN (raw -> 'results' -> 'verifierCalculations' ->> 'rawMaterialProcessing_normalized_mj')::numeric > 0
                    ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'rawMaterialProcessing_normalized_mj')::numeric > 0
                END
                AND 
                CASE 
                    WHEN raw ->> 'status' ILIKE '%VRF%' THEN
                        CASE 
                            WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantrawMaterialProcessing' ->> 'corrected')::numeric > 0
                            WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantrawMaterialProcessing' ->> 'corrected')::numeric > 0
                        END
                    ELSE
                        CASE 
                            WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantrawMaterialProcessing' ->> 'response')::numeric > 0
                            WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
                                THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantrawMaterialProcessing' ->> 'response')::numeric > 0
                        END
                END
            ) THEN TRUE

            ELSE FALSE
        END AS tier23_qualify,
        raw
    FROM 
        public.dct
    WHERE
        (raw ->> 'facilityPosted')::boolean = TRUE
        AND raw ->> 'status' NOT ILIKE '%ASD%'
        AND (
            raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%materialProduction%'
            OR raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%rawMaterialProcessing%'
    LIMIT 100
        )
    )

SELECT
	COUNT(DISTINCT account_id)
FROM cte
WHERE tier23_qualify = TRUE