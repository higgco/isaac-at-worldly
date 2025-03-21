SELECT
	ca.assessment_id,
	fem.status AS assessment_status,
	ca.id AS check_id,
	ca.status AS check_status,
	c.resolved_type
FROM public.assessment_data_check_actions AS ca
LEFT JOIN public.fem_simple AS fem
	USING (assessment_id)
LEFT JOIN public.assessment_data_check AS c
	USING (assessment_data_check_id)
LIMIT 100