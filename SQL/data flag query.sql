SELECT
	fem.account_id,
	fem.assessment_id,
	fem.status,
	facility_types.facility_type,
	fem.performance -> 'ensourcelngtotal' AS lng_mj,
	fem.performance -> 'ensourcetotal' AS total_mj,
	CASE WHEN (fem.status = 'VRF' AND fem.raw -> 'verifierData' ->> 'ensourcetrackopteach' NOT LIKE '[null]') 
		THEN fem.raw -> 'verifierData' ->> 'ensourcetrackopteach'
		ELSE fem.raw -> 'facilityData' ->> 'ensourcetrackopteach' END AS track_each,
	(fem.calculations ->> 'finalProductAssembly_total_mj')::NUMERIC AS final_product_assembly_mj,
	(fem.calculations ->> 'hardComponentTrimProduction_total_mj')::NUMERIC,
	

FROM public.fem_simple AS fem
LEFT JOIN LATERAL (
        -- Unnest the JSON array and then aggregate into a string
        SELECT STRING_AGG(value, ', ') AS facility_type
        FROM jsonb_array_elements_text(fem.performance -> 'sipfacilitytype') AS value
    ) AS facility_types ON true
WHERE 
	(CAST(fem.performance -> 'ensourcelngtotal' AS NUMERIC) > 1000000000
	OR CAST(fem.performance -> 'ensourcetotal' AS NUMERIC) > 10000000000
	OR (CAST(fem.performance -> 'ensourcetotal' AS NUMERIC) < 38574
		AND fem.performance ->> 'ensourcetrackopteach' = 'yes'))
	
LIMIT 100