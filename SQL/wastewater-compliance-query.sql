SELECT
	DISTINCT f.assessment_id,
	a.name,
	f.status,
	f.rfi_pid,
	CASE WHEN f.status = 'VRF'
		THEN (vflag ->> 'result')::boolean
		ELSE (flag ->> 'result')::boolean
	END AS sippermitsreqwastewatercompliance_result
FROM
public.fem_simple AS f
	INNER JOIN public.fem_shares AS s
	USING (assessment_id)
	INNER JOIN public.account AS a
	ON (a.account_id = f.account_id),
jsonb_array_elements(
    f.raw -> 'results' -> 'extensions' -> 'survey-flags' -> 'facilityFlags'
  ) AS flag,
jsonb_array_elements(
    f.raw -> 'results' -> 'extensions' -> 'survey-flags' -> 'verifierFlags'
  ) AS vflag
WHERE
  (CASE WHEN status = 'VRF'
  	THEN vflag ->> 'name'
	ELSE flag ->> 'name' END) = 'sippermitsreqwastewatercompliance'
  AND f.facility_posted = TRUE
  AND s.account_id = '5a8f3dfe56bbf7099c134cfe' --shared with Kohl's
ORDER BY 2