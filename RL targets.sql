with cte AS(
SELECT
    a.account_id,
    a.name AS facility_name,
    fdm.assessment_id,
    fdm.raw ->> 'name' AS assessment_name,
    fdm.raw ->> 'surveyVersion' AS survey_version,
    fdm.raw ->> 'status' AS status
FROM public.dct AS fdm
LEFT JOIN public.account AS a ON a.account_id = fdm.account_id
LEFT JOIN public.dct_shares AS s ON s.assessment_id = fdm.assessment_id
WHERE
    s.account_id = 'bbf1677f4621395211a6d61f064e1d32'
    AND s.share_status = 'accepted'
)

SELECT
    CASE WHEN (t.target_id) IS NULL THEN 'No Target' ELSE t.target_id END AS target_id,
    cte.account_id,
    cte.facility_name,
    COUNT(cte.assessment_id) AS assessment_count,
    t.form_data ->> 'source' AS target_source,
    t.form_data ->> 'targetArea' AS target_area,
    (t.form_data ->> 'targetYear')::numeric AS target_type,
    t.form_data ->> 'baselineUnit' AS target_baseline_unit,
    (t.form_data ->> 'baselineYear')::numeric AS target_baseline_year,
    t.form_data ->> 'facilityType' AS target_facility_type,
    t.form_data ->> 'measurementType' AS target_measurement_type,
    (t.form_data ->> 'baselineQuantity')::numeric AS target_baseline_quantity,
    t.form_data ->> 'targetDescription' AS target_description,
    t.form_data ->> 'targetChangeDirection' AS target_change_direction,
    (t.form_data ->> 'targetPercentageChange')::numeric AS target_percentage_change
FROM public.fdm_targets AS t
RIGHT JOIN cte ON t.account_id = cte.account_id
GROUP BY cte.account_id, cte.facility_name, t.target_id, t.form_data