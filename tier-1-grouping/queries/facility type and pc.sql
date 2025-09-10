-- DROP VIEW IF EXISTS fem_simple_090825;
-- CREATE VIEW fem_simple_090825 AS
-- SELECT * FROM public.fem_simple
-- WHERE 
--     rfi_pid IN ('fem2024', 'fem2023', 'fem2022')
--     AND status != 'ASD'
--     AND facility_posted = TRUE;

WITH cte AS (
SELECT 
    fem.assessment_id,
    fem.performance -> 'sipfacilitytype' AS sipfacilitytype,
    jsonb_array_length(fem.performance -> 'sipfacilitytype') AS facility_type_count,
    (fem.performance -> 'finalProductAssemblytotal')::numeric AS finished_product_assembly_prod_vol_pcs,
    fem.performance -> 'sipproductcategories' AS sipproductcategories,
    jsonb_array_length(fem.performance -> 'sipproductcategories') AS product_category_count,
    fem.performance -> 'sipfacilityapparelpc' AS sipfacilityapparelpc,
    jsonb_array_length(fem.performance -> 'sipfacilityapparelpc') AS apparel_pc_count,
    (fem.performance -> 'ensourcetotal')::numeric AS total_energy_mj,
    (fem.performance -> 'totalGHGemissions')::numeric AS totalGHGemissions,
    CASE WHEN (
        outliers.total_mj_outlier = TRUE
        OR outliers.total_mj_facility_type_outlier_ = TRUE
        OR outliers.normalized_mj_facility_type_outlier_ = TRUE
        OR outliers.year_over_year_mj_outlier = TRUE
    ) THEN TRUE
    ELSE FALSE
    END AS energy_outlier
FROM fem_simple_090825 AS fem
LEFT JOIN fem_data_outliers AS outliers
ON fem.assessment_id = outliers.assessment_id
WHERE rfi_pid = 'fem2024'
    AND fem.performance ->> 'sipfacilitytype' ILIKE '%Assembler%'
    AND fem.performance ->> 'sipproductcategories' ILIKE '%Apparel%'
)

SELECT 
    -- COUNT(
        DISTINCT assessment_id
        -- ) AS total_assessments,
        AS assessment_id,
    -- ROUND(
    --     (COUNT(assessment_id) * 100.0) / SUM(COUNT(assessment_id)) OVER(), 
    --     2
    -- ) AS percentage_of_total,
    -- facility_type_count,
    -- product_category_count
    finished_product_assembly_prod_vol_pcs,
    sipfacilityapparelpc,
    apparel_pc_count,
    total_energy_mj,
    totalGHGemissions,
    energy_outlier
    -- DISTINCT jsonb_array_elements_text(sipfacilityapparelpc) AS distinct_apparel_pc_values
FROM cte
WHERE
    facility_type_count = 1
    AND product_category_count = 1
-- GROUP BY 3
ORDER BY 1 DESC;