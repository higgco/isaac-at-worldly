SELECT
COUNT(DISTINCT dct.assessment_id) AS total_assessments,
dct.raw ->> 'status' AS status
FROM public.dct AS dct
INNER JOIN public.account AS a ON a.account_id = dct.account_id
WHERE
    (dct.raw ->> 'facilityPosted')::boolean = TRUE
    AND dct.raw ->> 'surveyVersion' = '3.0.0'
    AND a.demo = FALSE
    AND dct.raw ->> 'status' != 'ASD'
GROUP BY dct.raw ->> 'status'