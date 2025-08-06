with fdm AS(
SELECT
    DISTINCT dct.raw ->> '_id' AS assessment_id,
    dct.raw -> 'account' ->> '_id' AS account_id,
    dct.raw ->> 'surveyVersion' AS survey_version,
    a.demo AS demo,
    dct.raw ->> 'status' AS status,    
    (dct.raw ->> 'facilityPosted')::boolean AS facility_posted
FROM dct
LEFT JOIN public.account AS a
ON (dct.raw -> 'account' ->> '_id') = a.account_id
WHERE
    (dct.raw ->> 'facilityPosted')::boolean = true
    AND dct.raw ->> 'surveyVersion' = '3.0.0'
    AND a.demo = FALSE)

SELECT
    COUNT(DISTINCT assessment_id) AS count_fdm_assessments,
    COUNT(DISTINCT account_id) AS count_fdm_accounts
FROM fdm;