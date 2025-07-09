SELECT
	COUNT (DISTINCT assessment_id) AS count,
	account_id,
	raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year
	-- raw ->> 'status' AS status,
	-- (raw ->> 'facilityPosted')::boolean AS facility_posted,
	-- (raw ->> 'verifierPosted')::boolean AS verifier_posted,
	-- raw -> 'results' -> 'answers' -> 'reportingmonth' ->> 'response' AS reporting_month,
	-- raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year
FROM public.dct
WHERE
	(raw ->> 'facilityPosted')::boolean = TRUE
	AND raw ->> 'status' NOT ILIKE '%ASD%'
GROUP BY account_id, raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response'
ORDER BY 1 DESC