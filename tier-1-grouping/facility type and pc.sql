SELECT 
    assessment_id,
    performance -> 'sipfacilitytype' AS sipfacilitytype,
    jsonb_array_length(performance -> 'sipfacilitytype') AS facility_type_count,
    performance -> 'sipproductcategories' AS sipproductcategories,
    jsonb_array_length(performance -> 'sipproductcategories') AS product_category_count
FROM public.fem_simple
WHERE rfi_pid = 'fem2024'
    AND status != 'ASD'
    AND facility_posted = TRUE
    AND performance ->> 'sipfacilitytype' ILIKE '%Assembler%'
LIMIT 100;