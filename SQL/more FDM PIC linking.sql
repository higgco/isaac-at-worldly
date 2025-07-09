SELECT
	account_id,
	raw
FROM public.dct
WHERE
	(raw ->> 'facilityPosted')::boolean = TRUE
	AND raw ->> 'status' NOT ILIKE '%ASD%'
	AND(
		raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%finalProductAssembly%'
		OR raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE  '%printingProductDyeingAndLaundering%'
	)
	AND raw ->> 'status' ILIKE '%VRF'
LIMIT 100

CASE WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%' THEN
	CASE WHEN (
		raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%finalProductAssembly%'
		AND 
			CASE WHEN raw ->> 'status' ILIKE '%VRF%'
				THEN (raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric > 0
				ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric > 0
			END
		AND 
			CASE WHEN raw ->> 'status' ILIKE '%VRF%'
				THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfinalProductAssembly' ->> 'corrected')::numeric > 0
				ELSE (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfinalProductAssembly' ->> 'response')::numeric > 0
		

finalProductAssembly_normalized_mj
printingProductDyeingAndLaundering_normalized_mj

2.0.0:
sipfacilityprodvolquantfinalProductAssembly
sipfacilityprodvolquantprintingProductDyeingAndLaundering

3.0.0
sipfacilityannualprodvolquantfinalProductAssembly
sipfacilityannualprodvolquantprintingProductDyeingAndLaundering