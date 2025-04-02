SELECT
COUNT(DISTINCT assessment_id) AS assessment_count,
account_id
-- account_id,
-- raw -> 'status' AS status,
-- CASE WHEN raw ->> 'status' LIKE '%VRF%' 
-- 		THEN raw ->'verifierData'->>'sipfacilitytype'
-- 		ELSE raw ->'facilityData'->>'sipfacilitytype' END AS facility_type,
-- CASE WHEN raw ->> 'status' LIKE '%VRF%' 
-- 		THEN raw ->'verifierData'->>'ensourceelectricmetertrack'
-- 		ELSE raw ->'facilityData'->>'ensourceelectricmetertrack' END AS meters,
-- CASE WHEN raw ->> 'status' LIKE '%VRF%' 
-- 		THEN raw ->'verifierData'->>'ensourcetracksepdomprod'
-- 		ELSE raw ->'facilityData'->>'ensourcetracksepdomprod' END AS domprodsep
FROM public.dct
WHERE
	CASE WHEN raw ->> 'status' LIKE '%VRF%' 
		THEN raw ->'verifierData'->>'ensourceelectricmetertrack'
		ELSE raw ->'facilityData'->>'ensourceelectricmetertrack' END LIKE 'no'
	AND CASE WHEN raw ->> 'status' LIKE '%VRF%' 
		THEN raw ->'verifierData'->>'sipfacilitytype'
		ELSE raw ->'facilityData'->>'sipfacilitytype' END LIKE '%finalProductAssembly%'
	AND CASE WHEN raw ->> 'status' LIKE '%VRF%' 
		THEN raw ->'verifierData'->>'ensourcetracksepdomprod'
		ELSE raw ->'facilityData'->>'ensourcetracksepdomprod' END LIKE 'yes'	
	AND (CASE WHEN raw ->> 'status' LIKE '%VRF%' 
		THEN raw ->'verifierData'->>'energyseparate'
		ELSE raw ->'facilityData'->>'energyseparate' END LIKE 'yes'
		OR CASE WHEN raw ->> 'status' LIKE '%VRF%' 
		THEN raw ->'verifierData'->>'energyseparate'
		ELSE raw ->'facilityData'->>'energyseparate' END IS NULL)
	AND raw ->> 'surveyVersion' = '2.0.0'
	AND raw ->> 'facilityPosted' = 'true'
GROUP BY 2