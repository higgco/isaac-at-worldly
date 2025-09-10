with fdm AS (
SELECT
    assessment_id,
    raw ->> 'name' as assessment_name,
    raw -> 'account' ->> '_id' as fac_account_id,
    raw -> 'account' ->> 'name' as fac_account_name,
    raw ->> 'surveyVersion' as surveyVersion,
    raw ->> 'status' as status,
    raw -> 'results' -> 'answers' -> 'sipvalidoperatinglicense' ->> 'response' as sipvalidoperatinglicense
FROM public.dct
WHERE
    (raw -> 'facilityPosted')::boolean = TRUE
    AND raw ->> 'surveyVersion' = '3.0.0'
    AND raw -> 'results' -> 'answers' -> 'sipvalidoperatinglicense' ->> 'response' IS NULL
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

