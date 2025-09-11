with fdm AS (
SELECT
    dct.assessment_id,
    dct.raw ->> 'name' as assessment_name,
    dct.raw -> 'account' ->> '_id' as fac_account_id,
    dct.raw -> 'account' ->> 'name' as fac_account_name,
    dct.raw ->> 'surveyVersion' as surveyVersion,
    dct.raw ->> 'status' as status,
    dct.raw -> 'results' -> 'answers' -> 'sipvalidoperatinglicense' ->> 'response' as sipvalidoperatinglicense
FROM public.dct AS dct
LEFT JOIN public.account AS a
ON dct.raw -> 'account' ->> '_id' = a.account_id
WHERE
    (dct.raw -> 'facilityPosted')::boolean = TRUE
    AND dct.raw ->> 'surveyVersion' = '3.0.0'
    AND dct.raw -> 'results' -> 'answers' -> 'sipvalidoperatinglicense' ->> 'response' IS NULL
    AND a.demo = FALSE
),

brand AS (
SELECT
    account_id,
    name
FROM public.account
),

preagg AS (
SELECT 
    b.account_id AS brand_account_id,
    b.name AS brand_name,
    fdm.assessment_id,
    fdm.assessment_name,
    fdm.fac_account_id,
    fdm.fac_account_name
FROM fdm
INNER JOIN public.dct_shares AS s
ON fdm.assessment_id = s.assessment_id
INNER JOIN brand AS b
ON s.account_id = b.account_id
GROUP BY 1, 2, 3, 4, 5, 6
ORDER BY 1 DESC
)

SELECT
    pa.brand_account_id,
    pa.brand_name,
    STRING_AGG(DISTINCT pa.assessment_id, ';') AS assessment_ids_list,
    STRING_AGG(DISTINCT pa.fac_account_id, ';') AS facility_account_ids_list,
    STRING_AGG(DISTINCT pa.fac_account_name, ';') AS facility_names_list
FROM preagg AS pa
GROUP BY 1, 2
ORDER BY 1 DESC