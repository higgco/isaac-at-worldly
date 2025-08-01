with wat_cte AS (
SELECT
    CUBE.assessment_id AS assessment_id,
    CUBE.status AS status,
    CUBE.rfi_pid AS rfi_pid,
	CASE WHEN (((CUBE.facility_posted = TRUE) OR (CUBE.verifier_posted = TRUE)) AND CUBE.status != 'ASD')
		THEN TRUE ELSE FALSE END AS ih_eligible,
    CUBE.performance ->> 'sipfacilitytype' AS sipfacilitytype,
    CUBE.performance->>'wattrackdomprodsep' AS wattrackdomprodsep,
    (CUBE.performance->>'production_water_use')::numeric AS production_water_use,
    (CUBE.performance->>'domestic_total_water_l')::numeric AS domestic_total_water_l,
    (CUBE.performance->>'watsourcetotaltotal')::numeric AS watsourcetotaltotal,

    (CUBE.performance ->> 'finalProductAssembly_water_l')::numeric AS finalProductAssembly_water_l,
    (CUBE.calculations ->> 'finalProductAssembly_total_water_l')::numeric AS finalProductAssembly_water_l_adjusted,

    (CUBE.performance ->> 'printingProductDyeingAndLaundering_water_l')::numeric AS printingProductDyeingAndLaundering_water_l,
    (CUBE.calculations ->> 'printingProductDyeingAndLaundering_total_water_l')::numeric AS printingProductDyeingAndLaundering_water_l_adjusted,

    (CUBE.performance ->> 'hardComponentTrimProduction_water_l')::numeric AS hardComponentTrimProduction_water_l,
    (CUBE.calculations ->> 'hardComponentTrimProduction_total_water_l')::numeric AS hardComponentTrimProduction_water_l_adjusted,
    
    (CUBE.performance ->> 'materialProduction_water_l')::numeric AS materialProduction_water_l,
    (CUBE.calculations ->> 'materialProduction_total_water_l')::numeric AS materialProduction_water_l_adjusted,

    (CUBE.performance ->> 'rawMaterialProcessing_water_l')::numeric AS rawMaterialProcessing_water_l,
    (CUBE.calculations ->> 'rawMaterialProcessing_total_water_l')::numeric AS rawMaterialProcessing_water_l_adjusted,

    (CUBE.performance ->> 'rawMaterialCollection_water_l')::numeric AS rawMaterialCollection_water_l,
    (CUBE.calculations ->> 'rawMaterialCollection_total_water_l')::numeric AS rawMaterialCollection_water_l_adjusted,

    (CUBE.performance ->> 'finalProductAssemblytotal')::numeric AS finalProductAssemblytotal,
    (CUBE.performance ->> 'printingProductDyeingAndLaunderingtotal')::numeric AS printingProductDyeingAndLaunderingtotal,
    (CUBE.performance ->> 'hardComponentTrimProductiontotal')::numeric AS hardComponentTrimProductiontotal,
    (CUBE.performance ->> 'materialProductiontotal')::numeric AS materialProductiontotal,
    (CUBE.performance ->> 'rawMaterialProcessingtotal')::numeric AS rawMaterialProcessingtotal,
    (CUBE.performance ->> 'rawMaterialCollectiontotal')::numeric AS rawMaterialCollectiontotal,
    (CUBE.performance ->> 'water_intensity_l_pc')::numeric AS water_intensity_l_pc,
    (CUBE.performance ->> 'water_intensity_l_kg')::numeric AS water_intensity_l_kg,

    CUBE.performance ->> 'watproduse' AS watproduse,

	CASE WHEN (
        ((CUBE.performance->>'watsourcetotaltotal')::numeric > 1957500000)
        OR ((CUBE.performance->>'watsourcetotaltotal')::numeric < 0)
        OR ((CUBE.performance->>'finalProductAssembly_water_l')::numeric > 320800000)
        OR ((CUBE.performance->>'hardComponentTrimProduction_water_l')::numeric > 220600000)
        OR ((CUBE.performance->>'materialProduction_water_l')::numeric > 1907900000)
        OR ((CUBE.performance->>'printingProductDyeingAndLaundering_water_l')::numeric > 1379700000)
        OR ((CUBE.performance->>'rawMaterialProcessing_water_l')::numeric > 617700000)
        OR ((CUBE.performance->>'rawMaterialCollection_water_l')::numeric > 617700000)
        OR ((CUBE.performance->>'domestic_total_water_l')::numeric > 366700000)
        OR (((CUBE.performance->>'finalProductAssembly_water_l')::numeric) / NULLIF((CUBE.performance->>'finalProductAssemblytotal')::numeric, 0) > 2288)
        OR (((CUBE.performance->>'hardComponentTrimProduction_water_l')::numeric) / NULLIF((CUBE.performance->>'hardComponentTrimProductiontotal')::numeric, 0) > 1471)
        OR (((CUBE.performance->>'materialProduction_water_l')::numeric) / NULLIF((CUBE.performance->>'materialProductiontotal')::numeric, 0) > 1059)
        OR (((CUBE.performance->>'printingProductDyeingAndLaundering_water_l')::numeric) / NULLIF((CUBE.performance->>'printingProductDyeingAndLaunderingtotal')::numeric, 0) > 5642)
        OR (((CUBE.performance->>'rawMaterialProcessing_water_l')::numeric) / NULLIF((CUBE.performance->>'rawMaterialProcessingtotal')::numeric, 0) > 587)
        OR (((CUBE.performance->>'rawMaterialCollection_water_l')::numeric) / NULLIF((CUBE.performance->>'rawMaterialCollectiontotal')::numeric, 0) > 587)
	) 
    THEN TRUE 
    ELSE FALSE 
	END AS outlier

FROM fem_simple CUBE
WHERE (((CUBE.facility_posted = TRUE) OR (CUBE.verifier_posted = TRUE)) AND CUBE.status != 'ASD')
    AND (CUBE.rfi_pid = 'fem2023' OR CUBE.rfi_pid = 'fem2024')
    AND (CUBE.performance ->> 'water_intensity_l_kg')::numeric IS NOT NULL
LIMIT 1000
)

-- SELECT
--     SUM(finalProductAssembly_water_l) / SUM(finalProductAssemblytotal) AS finalProductAssembly_water_intensity
-- FROM wat_cte
-- WHERE watsourcetotaltotal > 0 AND rfi_pid = 'fem2024' AND outlier = FALSE
--     AND watproduse ILIKE 'Yes'
-------
-- SELECT
-- assessment_id,
-- water_intensity_l_pc
-- FROM wat_cte
-- WHERE watsourcetotaltotal > 0 AND rfi_pid = 'fem2024' AND outlier = FALSE AND sipfacilitytype ILIKE '%Finished Product Assembler%'
--     -- AND watproduse ILIKE 'Yes'
--------
-- SELECT
-- SUM(finalProductAssembly_water_l_adjusted) / SUM(finalProductAssemblytotal) AS finalProductAssembly_water_intensity_adjusted
-- FROM wat_cte
-- WHERE watsourcetotaltotal > 0 AND rfi_pid = 'fem2024' AND outlier = FALSE
--     AND watproduse ILIKE 'Yes'
--------
-- SELECT
-- SUM(
--     printingProductDyeingAndLaundering_water_l_adjusted +
--     hardComponentTrimProduction_water_l_adjusted +
--     materialProduction_water_l_adjusted +
--     rawMaterialProcessing_water_l_adjusted +
--     rawMaterialCollection_water_l_adjusted
-- ) /
-- SUM(
--     printingProductDyeingAndLaunderingtotal +
--     hardComponentTrimProductiontotal +
--     materialProductiontotal +
--     rawMaterialProcessingtotal +
--     rawMaterialCollectiontotal
-- ) AS tier234_water_intensity_adjusted
-- FROM wat_cte
-- WHERE watsourcetotaltotal > 0 AND rfi_pid = 'fem2024' AND outlier = FALSE
--     AND watproduse ILIKE 'Yes'
--------
-- SELECT
-- SUM(
--     printingProductDyeingAndLaundering_water_l +
--     hardComponentTrimProduction_water_l +
--     materialProduction_water_l +
--     rawMaterialProcessing_water_l +
--     rawMaterialCollection_water_l
-- ) /
-- SUM(
--     printingProductDyeingAndLaunderingtotal +
--     hardComponentTrimProductiontotal +
--     materialProductiontotal +
--     rawMaterialProcessingtotal +
--     rawMaterialCollectiontotal
-- ) AS tier234_water_intensity
-- FROM wat_cte
-- WHERE watsourcetotaltotal > 0 AND rfi_pid = 'fem2024' AND outlier = FALSE
--     AND watproduse ILIKE 'Yes'
--------
SELECT
assessment_id,
water_intensity_l_kg
FROM wat_cte
WHERE watsourcetotaltotal > 0 AND rfi_pid = 'fem2024' AND outlier = FALSE 
    AND (sipfacilitytype ILIKE '%Finished Product Processing%'
        OR sipfacilitytype ILIKE '%Component%'
        OR sipfacilitytype ILIKE '%Material Production%'
        OR sipfacilitytype ILIKE '%Raw Material Processing%'
        OR sipfacilitytype ILIKE '%Raw Material Collection%')
    AND watproduse ILIKE 'Yes'
