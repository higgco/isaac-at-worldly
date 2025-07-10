with cte AS(
SELECT
    a.account_id,
	a.active,
    a.created_on,
	fslm.assessment_id AS fslm_assessment,
	fslm."ASC" AS fslm_asc,
	fem.assessment_id AS fem_assessment,
	fem."ASC" AS fem_asc
FROM
    public.account AS a
LEFT JOIN
	public.fem_simple AS fem 
ON a.account_id = fem.account_id
LEFT JOIN
	public.fslm AS fslm
ON fslm.account_id = a.account_id
WHERE
    a.created_on >= CURRENT_DATE - INTERVAL '1 year'
	AND ((fslm.assessment_id IS NOT NULL AND fslm."ASC" IS NOT NULL)
	OR (fem.assessment_id IS NOT NULL AND fem."ASC" IS NOT NULL))
ORDER BY 1 DESC
)

SELECT 
    account_id,
	(
	(CASE WHEN fslm_asc IS NULL THEN fem_asc
		WHEN fem_asc IS NULL THEN fslm_asc
		WHEN fem_asc < fslm_asc THEN fem_asc
		ELSE fslm_asc END)::date - created_on::date) AS diff_days
FROM 
    cte
WHERE active = TRUE;