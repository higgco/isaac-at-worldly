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
    fdm.assessment_id,
    fdm.assessment_name,
    fdm.fac_account_id,
    fdm.fac_account_name,
    STRING_AGG(DISTINCT s.account_id, ';') AS account_ids_list,
    STRING_AGG(DISTINCT b.name, ';') AS brand_names_list
FROM fdm
INNER JOIN public.dct_shares AS s
ON fdm.assessment_id = s.assessment_id
LEFT JOIN brand AS b
ON s.account_id = b.account_id
GROUP BY 1, 2, 3, 4
ORDER BY 1 DESC
)

SELECT
    pa.fac_account_id,
    pa.fac_account_name,
    STRING_AGG(DISTINCT pa.assessment_id, ';') AS assessment_ids_list,
    STRING_AGG(DISTINCT pa.assessment_name, ';') AS assessment_names_list,
    STRING_AGG(DISTINCT pa.account_ids_list, ';') AS brand_account_ids_list,
    STRING_AGG(DISTINCT pa.brand_names_list, ';') AS brand_names_list
FROM preagg AS pa
GROUP BY 1, 2
ORDER BY 1 DESC

