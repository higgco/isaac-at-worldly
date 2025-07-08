SELECT
	assessment_id,
	account_id,
	raw ->> 'status' AS status,
	raw ->> 'facilityPosted' AS facility_posted,
	raw -> 'results' -> 'answers' -> 'reportingmonth' ->> 'response' AS reporting_month,
	raw -> 'results' -> 'answers' -> 'reportingyear' ->> 'response' AS reporting_year
FROM public.dct
LIMIT 100