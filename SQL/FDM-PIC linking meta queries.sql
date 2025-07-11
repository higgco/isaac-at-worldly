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
	DISTINCT fdm.assessment_id,
	fdm.account_id,
	fdm.raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year,
	cte.facility_types,
	fdm.raw ->> 'status' AS status,
	CASE 
		WHEN fdm.raw ->> 'surveyVersion' ILIKE '%2.0.0%'
			THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityprodvolquantfinalProductAssembly' ->> 'response')::numeric
		WHEN fdm.raw ->> 'surveyVersion' ILIKE '%3.0.0%'
			THEN (fdm.raw -> 'results' -> 'answers' -> 'sipfacilityannualprodvolquantfinalProductAssembly' ->> 'response')::numeric
	END AS production_volume,
	CASE 
		WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
			THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_normalized_kgco2e')::numeric
		ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_normalized_kgco2e')::numeric
	END AS finalProductAssembly_normalized_kgco2e,
	CASE 
		WHEN fdm.raw ->> 'status' ILIKE '%VRF%'
			THEN (fdm.raw -> 'results' -> 'verifierCalculations' ->> 'finalProductAssembly_total_kgco2e')::numeric
		ELSE (fdm.raw -> 'results' -> 'facilityCalculations' ->> 'finalProductAssembly_total_kgco2e')::numeric
	END AS finalProductAssembly_total_kgco2e,
	-- fdm.raw,
	-- (raw ->> 'facilityPosted')::boolean AS facility_posted,
	-- (raw ->> 'verifierPosted')::boolean AS verifier_posted,
	fdm.raw -> 'results' -> 'answers' -> 'reportingmonth' ->> 'response' AS reporting_month
	-- raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year
FROM public.dct AS fdm
INNER JOIN cte
USING (account_id)
WHERE
	(fdm.raw ->> 'facilityPosted')::boolean = TRUE
	AND fdm.raw ->> 'status' NOT ILIKE '%ASD%'
	AND cte.tier1_qualify = TRUE
	AND fdm.raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' LIKE '2024'
	AND fdm.account_id = '51af1301aad8beff4fbd2a051f72872f'
ORDER BY 1 DESC
