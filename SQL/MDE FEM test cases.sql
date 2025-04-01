SELECT
	assessment_id,
	fem.raw -> 'verifierData' -> 'sipfacilitytype' AS facility_type,
	answers -> 'sipmaterialtextiles' AS sipmaterialtextiles,
	answers -> 'sipfacilitymaterialprocesstextiles' AS textile_processes,
	answers -> 'sitecountry' AS textile_processes,
	rfi_pid,
	performance -> 'ensourcetotal' AS total_mj,
	calculations -> 'rawMaterialProcessing_normalized_kgco2e' AS rawMaterialProcessing_normalized_kgco2e,
	calculations -> 'materialProduction_normalized_kgco2e' AS materialProduction_normalized_kgco2e
FROM public.fem_simple AS fem
WHERE
	fem.status = 'VRF'
	AND (fem.raw -> 'verifierData' ->> 'sipfacilitytype' LIKE '%rawMaterialProcessing%'
		OR fem.raw -> 'verifierData' ->> 'sipfacilitytype' LIKE '%materialProduction%')
	AND rfi_pid = 'fem2023'