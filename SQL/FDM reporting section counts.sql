WITH total AS (
    SELECT
        COUNT(DISTINCT assessment_id) AS total_count
    FROM public.dct
    WHERE (raw ->> 'facilityPosted')::boolean = TRUE
),

three AS (
    SELECT
        COUNT(DISTINCT assessment_id) AS three_count
    FROM public.dct
    WHERE
        raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' ILIKE '%production%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' ILIKE '%energyuse%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' ILIKE '%wateruse%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' NOT ILIKE '%waste%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' NOT ILIKE '%wastewater%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' NOT ILIKE '%airemissions%'
		AND (raw ->> 'facilityPosted')::boolean = TRUE
),

four AS (
    SELECT
        COUNT(DISTINCT assessment_id) AS four_count
    FROM public.dct
    WHERE
        raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' ILIKE '%production%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' ILIKE '%energyuse%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' ILIKE '%wateruse%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' ILIKE '%waste%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' NOT ILIKE '%wastewater%'
        AND raw -> 'results' -> 'answers' -> 'report_sections' ->> 'response' NOT ILIKE '%airemissions%'
		AND (raw ->> 'facilityPosted')::boolean = TRUE
)

SELECT 
    total.total_count,
    three.three_count,
    four.four_count
FROM total, three, four;