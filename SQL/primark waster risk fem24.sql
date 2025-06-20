SELECT
	a.name,
	a.sac_id AS worldly_id,
	fem.status,
	fem.assessment_id,
	fem.calculations -> 'appWater' AS water_applicability,
	fem.performance -> 'water_applicability' AS perf_wat_app,
	CASE WHEN
		fem.performance ->> 'water_levelsAchieved' LIKE '%1%' THEN TRUE ELSE FALSE
	END AS achieved_water_level1
FROM public.fem_simple AS fem
LEFT JOIN public.fem_shares AS s
ON (fem.assessment_id = s.assessment_id)
LEFT JOIN public.account AS a
ON (a.account_id = fem.account_id)
WHERE 
	fem.rfi_pid = 'fem2024'
	AND s.share_status = 'accepted'
    AND fem.facility_posted = 'true'
    AND fem.status <> 'ASD'
	AND s.account_id = '5a0e3c5e7d1a7e0a99edfd28'