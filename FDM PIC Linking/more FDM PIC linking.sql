with cte AS(
	SELECT
		account_id,
		raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' AS facility_types,
		CASE 
			WHEN raw ->> 'status' ILIKE '%VRF%'
				THEN (raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric
			ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric
		END AS finalProductAssembly_normalized_mj,
		CASE 
			WHEN raw ->> 'status' ILIKE '%VRF%'
				THEN (raw -> 'results' -> 'verifierCalculations' ->> 'printingProductDyeingAndLaundering_normalized_mj')::numeric
			ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'printingProductDyeingAndLaundering_normalized_mj')::numeric
		END AS printingProductDyeingAndLaundering_normalized_mj,
		CASE 
			WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
				THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfinalProductAssembly' ->> 'response')::numeric
			WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
				THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantfinalProductAssembly' ->> 'response')::numeric
		END AS finalProductAssembly_prodvol,
		CASE 
			WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
				THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantprintingProductDyeingAndLaundering' ->> 'response')::numeric
			WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
				THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantprintingProductDyeingAndLaundering' ->> 'response')::numeric
		END AS printingProductDyeingAndLaundering_prodvol,
		CASE 
			WHEN (
				raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%finalProductAssembly%'
				AND 
				CASE 
					WHEN raw ->> 'status' ILIKE '%VRF%'
						THEN (raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric > 0
					ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_normalized_mj')::numeric > 0
				END
				AND 
				CASE 
					WHEN raw ->> 'status' ILIKE '%VRF%' THEN
						CASE 
							WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfinalProductAssembly' ->> 'corrected')::numeric > 0
							WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantfinalProductAssembly' ->> 'corrected')::numeric > 0
						END
					ELSE
						CASE 
							WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfinalProductAssembly' ->> 'response')::numeric > 0
							WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantfinalProductAssembly' ->> 'response')::numeric > 0
						END
				END
			) THEN TRUE
	
			WHEN (
				raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%printingProductDyeingAndLaundering%'
				AND 
				CASE 
					WHEN raw ->> 'status' ILIKE '%VRF%'
						THEN (raw -> 'results' -> 'verifierCalculations' ->> 'printingProductDyeingAndLaundering_normalized_mj')::numeric > 0
					ELSE (raw -> 'results' -> 'facilityCalculations' ->> 'printingProductDyeingAndLaundering_normalized_mj')::numeric > 0
				END
				AND 
				CASE 
					WHEN raw ->> 'status' ILIKE '%VRF%' THEN
						CASE 
							WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantprintingProductDyeingAndLaundering' ->> 'corrected')::numeric > 0
							WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantprintingProductDyeingAndLaundering' ->> 'corrected')::numeric > 0
						END
					ELSE
						CASE 
							WHEN raw ->> 'surveyVersion' ILIKE '%2.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantprintingProductDyeingAndLaundering' ->> 'response')::numeric > 0
							WHEN raw ->> 'surveyVersion' ILIKE '%3.0.0%'
								THEN (raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantprintingProductDyeingAndLaundering' ->> 'response')::numeric > 0
						END
				END
			) THEN TRUE
	
			ELSE FALSE
		END AS tier1_qualify,
		raw
	FROM 
		public.dct
	WHERE
		(raw ->> 'facilityPosted')::boolean = TRUE
		AND raw ->> 'status' NOT ILIKE '%ASD%'
		AND (
			raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%finalProductAssembly%'
			OR raw -> 'results' -> 'answers' -> 'sipfacilitytype' ->> 'response' ILIKE '%printingProductDyeingAndLaundering%'
		)
)

SELECT
	COUNT(DISTINCT account_id)
FROM cte
WHERE tier1_qualify = TRUE