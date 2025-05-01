DROP TABLE IF EXISTS isaac_hopwood.fem2023_24_answers_tmp;

CREATE TABLE isaac_hopwood.fem2023_24_answers_tmp AS
SELECT
    assessment_id,
	rfi_pid,
    raw -> 'results' -> 'answers' AS answers
FROM public.fem_simple
WHERE
    (rfi_pid = 'fem2023' OR rfi_pid = 'fem2024')
    AND facility_posted = true
    AND status <> 'ASD'