DROP TABLE IF EXISTS isaac_hopwood.adjusted_facility_impacts;

CREATE TABLE isaac_hopwood.adjusted_facility_impacts AS

SELECT
	assessment_id,
	rfi_pid,
	status,

	(performance-> 'domestic_total_kgco2e')::numeric AS domestic_total_kgco2e,
	(performance-> 'vehicle_total_kgco2e')::numeric AS vehicle_total_kgco2e,

	(calculations -> 'finalProductAssembly_kgco2e')::numeric AS finalProductAssembly_ghg,
	(calculations -> 'finalProductAssembly_total_kgco2e')::numeric AS finalProductAssembly_ghg_adjusted,
	(( (calculations -> 'finalProductAssembly_total_kgco2e')::numeric - (calculations -> 'finalProductAssembly_kgco2e')::numeric )
	 / NULLIF((calculations -> 'finalProductAssembly_kgco2e')::numeric, 0)) * 100 AS finalProductAssembly_ghg_pct_diff,

	(calculations -> 'printingProductDyeingAndLaundering_kgco2e')::numeric AS printingProductDyeingAndLaundering_ghg,
	(calculations -> 'printingProductDyeingAndLaundering_total_kgco2e')::numeric AS printingProductDyeingAndLaundering_ghg_adjusted,
	(( (calculations -> 'printingProductDyeingAndLaundering_total_kgco2e')::numeric - (calculations -> 'printingProductDyeingAndLaundering_kgco2e')::numeric )
	 / NULLIF((calculations -> 'printingProductDyeingAndLaundering_kgco2e')::numeric, 0)) * 100 AS printingProductDyeingAndLaundering_ghg_pct_diff,

	(calculations -> 'hardComponentTrimProduction_kgco2e')::numeric AS hardComponentTrimProduction_ghg,
	(calculations -> 'hardComponentTrimProduction_total_kgco2e')::numeric AS hardComponentTrimProduction_ghg_adjusted,
	(( (calculations -> 'hardComponentTrimProduction_total_kgco2e')::numeric - (calculations -> 'hardComponentTrimProduction_kgco2e')::numeric )
	 / NULLIF((calculations -> 'hardComponentTrimProduction_kgco2e')::numeric, 0)) * 100 AS hardComponentTrimProduction_ghg_pct_diff,

	(calculations -> 'materialProduction_kgco2e')::numeric AS materialProduction_ghg,
	(calculations -> 'materialProduction_total_kgco2e')::numeric AS materialProduction_ghg_adjusted,
	(( (calculations -> 'materialProduction_total_kgco2e')::numeric - (calculations -> 'materialProduction_kgco2e')::numeric )
	 / NULLIF((calculations -> 'materialProduction_kgco2e')::numeric, 0)) * 100 AS materialProduction_ghg_pct_diff,

	(calculations -> 'rawMaterialProcessing_kgco2e')::numeric AS rawMaterialProcessing_ghg,
	(calculations -> 'rawMaterialProcessing_total_kgco2e')::numeric AS rawMaterialProcessing_ghg_adjusted,
	(( (calculations -> 'rawMaterialProcessing_total_kgco2e')::numeric - (calculations -> 'rawMaterialProcessing_kgco2e')::numeric )
	 / NULLIF((calculations -> 'rawMaterialProcessing_kgco2e')::numeric, 0)) * 100 AS rawMaterialProcessing_ghg_pct_diff,

	(calculations -> 'rawMaterialCollection_kgco2e')::numeric AS rawMaterialCollection_ghg,
	(calculations -> 'rawMaterialCollection_total_kgco2e')::numeric AS rawMaterialCollection_ghg_adjusted,
	(( (calculations -> 'rawMaterialCollection_total_kgco2e')::numeric - (calculations -> 'rawMaterialCollection_kgco2e')::numeric )
	 / NULLIF((calculations -> 'rawMaterialCollection_kgco2e')::numeric, 0)) * 100 AS rawMaterialCollection_ghg_pct_diff

FROM public.fem_simple
WHERE
	(rfi_pid = 'fem2023' OR rfi_pid = 'fem2024')
	AND facility_posted = TRUE