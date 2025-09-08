DROP TABLE IF EXISTS fem_simple_temp_090825;
CREATE TABLE TEMP AS (
SELECT * FROM public.fem_simple
WHERE 
    rfi_pid IN ('fem2024', 'fem2023', 'fem2022')
    AND status != 'ASD'
    AND facility_posted = TRUE
);

WITH cte AS (
SELECT 
    assessment_id,
    performance -> 'sipfacilitytype' AS sipfacilitytype,
    jsonb_array_length(performance -> 'sipfacilitytype') AS facility_type_count,
    performance -> 'sipproductcategories' AS sipproductcategories,
    jsonb_array_length(performance -> 'sipproductcategories') AS product_category_count
FROM fem_simple_temp_090825
WHERE rfi_pid = 'fem2024'
    AND performance ->> 'sipfacilitytype' ILIKE '%Assembler%'
    AND performance ->> 'sipproductcategories' ILIKE '%Apparel%'
)

SELECT 
    COUNT(assessment_id) AS total_assessments
    -- ROUND(
    --     (COUNT(assessment_id) * 100.0) / SUM(COUNT(assessment_id)) OVER(), 
    --     2
    -- ) AS percentage_of_total,
    -- facility_type_count,
    -- product_category_count
FROM cte
WHERE
    facility_type_count = 1
    AND product_category_count = 1
-- GROUP BY 3, 4
ORDER BY 1 DESC;