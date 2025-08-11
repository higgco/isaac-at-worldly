with fdm AS(
SELECT
    DISTINCT dct.raw ->> '_id' AS assessment_id,
    dct.raw -> 'account' ->> '_id' AS account_id,
    dct.raw ->> 'status' AS status,
    dct.raw -> 'results' -> 'answers' -> 'reportingmonth' ->> 'response' AS reporting_month,
    dct.raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year,  
    (dct.raw ->> 'facilityPosted')::boolean AS facility_posted
FROM dct
LEFT JOIN public.account AS a
ON (dct.raw -> 'account' ->> '_id') = a.account_id
WHERE
    (dct.raw ->> 'facilityPosted')::boolean = TRUE
    AND dct.raw ->> 'surveyVersion' = '3.0.0'
    AND a.demo = FALSE
),

acc AS (
SELECT
    a.name,
    a.account_id,
    s.assessment_id
FROM account AS a
LEFT JOIN dct_shares AS s
    ON a.account_id = s.account_id
)

SELECT
    fdm.account_id AS fac_account_id,
    fdm.assessment_id,
    fdm.reporting_month,
    fdm.reporting_year,
    STRING_AGG(acc.name, ', ') AS accounts_shared_with
FROM fdm
LEFT JOIN acc
    ON fdm.assessment_id = acc.assessment_id
GROUP BY fdm.assessment_id, fdm.account_id, fdm.reporting_month, fdm.reporting_year