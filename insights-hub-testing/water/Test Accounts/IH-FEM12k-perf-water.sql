SELECT
	DISTINCT CUBE.assessment_id AS assessment_id,
    a.name AS account_name,
	CUBE.status AS status,
	CASE WHEN (((CUBE.facility_posted = TRUE) OR (CUBE.verifier_posted = TRUE)) AND CUBE.status != 'ASD')
		THEN TRUE ELSE FALSE END AS ih_eligible,	
	CUBE.performance->>'rfi_pid' AS rfi_pid,
	CUBE.performance->>'sitecountry' AS sitecountry,

	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipindustrysector') AS element) AS sipindustrysector,	
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipproductcategories') AS element) AS sipproductcategories,

	(CUBE.performance->>'sipfulltimeemployees')::numeric AS sipfulltimeemployees,
	(CUBE.performance->>'watopdays')::numeric AS watopdays,

    (CUBE.performance->>'total_water_score')::numeric AS total_water_score,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'water_levelsAchieved') AS element) AS water_levelsAchieved,
	CUBE.performance->>'achieved_water_level1' AS achieved_water_level1,
	
    -- Facility Type
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilitytype') AS element) AS sipfacilitytype,
	CASE WHEN (
		CUBE.performance->>'sipfacilitytype' LIKE '%Final Product Assembly%' OR
		CUBE.performance->>'sipfacilitytype' LIKE '%Finished Product Assembler%')
		THEN TRUE ELSE FALSE
	END AS finished_product_assembler,
	CASE WHEN (
		CUBE.performance->>'sipfacilitytype' LIKE '%Printing, Product Dyeing and Laundering%' OR
		CUBE.performance->>'sipfacilitytype' LIKE '%Finished Product Processing%')
		THEN TRUE ELSE FALSE
	END AS finished_product_processing,
	CASE WHEN (
		CUBE.performance->>'sipfacilitytype' LIKE '%Packaging Production%' OR
		CUBE.performance->>'sipfacilitytype' LIKE '%Hard Product Component%' OR
		CUBE.performance->>'sipfacilitytype' LIKE '%Component / Sub-Assembly Manufacturing%')
		THEN TRUE ELSE FALSE
	END AS component_subassembly_manufacturing,
	CASE WHEN (
		CUBE.performance->>'sipfacilitytype' LIKE '%Material Production%')
		THEN TRUE ELSE FALSE
	END AS material_production,	
	CASE WHEN (
		CUBE.performance->>'sipfacilitytype' LIKE '%Raw Material Processing%')
		THEN TRUE ELSE FALSE
	END AS raw_material_processing,
	CASE WHEN (
		CUBE.performance->>'sipfacilitytype' LIKE '%Chemical & Raw Material Production%' OR
		CUBE.performance->>'sipfacilitytype' LIKE '%Raw Material Collection%')
		THEN TRUE ELSE FALSE
	END AS raw_material_collection,

    (CUBE.performance->>'finalProductAssemblytotal')::numeric AS finalProductAssemblytotal,
    (CUBE.performance->>'printingProductDyeingAndLaunderingtotal')::numeric AS printingProductDyeingAndLaunderingtotal,
    (CUBE.performance->>'hardComponentTrimProductiontotal')::numeric AS hardComponentTrimProductiontotal,
    (CUBE.performance->>'materialProductiontotal')::numeric AS materialProductiontotal,
    (CUBE.performance->>'rawMaterialProcessingtotal')::numeric AS rawMaterialProcessingtotal,
    (CUBE.performance->>'rawMaterialCollectiontotal')::numeric AS rawMaterialCollectiontotal,

    CUBE.performance->>'wattrackdomprodsep' AS wattrackdomprodsep,

    --Sources
    CUBE.performance->>'watsourcetrackopt' AS watsourcetrackopt,
    CUBE.performance->>'watsourcetrackoptall' AS watsourcetrackoptall,
	
    (CUBE.performance->>'watsourcetotaltotal')::numeric AS watsourcetotaltotal,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'watsource') AS element) AS watsource, --water sources
    (CUBE.performance->>'watsourcesurfacetotal')::numeric AS watsourcesurfacetotal,
    (CUBE.performance->>'watsourceraintotal')::numeric AS watsourceraintotal,
    (CUBE.performance->>'watsourcegroundtotal')::numeric AS watsourcegroundtotal,
    (CUBE.performance->>'watsourcemunicipaltotal')::numeric AS watsourcemunicipaltotal,
    (CUBE.performance->>'watsourceseatotal')::numeric AS watsourceseatotal,
    (CUBE.performance->>'watsourceprodtotal')::numeric AS watsourceprodtotal,
    (CUBE.performance->>'watsourcewastewatertotal')::numeric AS watsourcewastewatertotal,
    (CUBE.performance->>'watsourcecombtotal')::numeric AS watsourcecombtotal,
    (CUBE.performance->>'watsourcemunicipalbluetotal')::numeric AS watsourcemunicipalbluetotal,
    (CUBE.performance->>'watsourcemunicipalunktotal')::numeric AS watsourcemunicipalunktotal,
    (CUBE.performance->>'watsourcecondtotal')::numeric AS watsourcecondtotal,
    (CUBE.performance->>'watsourcemunicipalgreytotal')::numeric AS watsourcemunicipalgreytotal,
    (CUBE.performance->>'watsourcerecycletotal')::numeric AS watsourcerecycletotal,
    (CUBE.performance->>'watsourcereusetotal')::numeric AS watsourcereusetotal,
    (CUBE.performance->>'watsourcewastetotal')::numeric AS watsourcewastetotal,
    (CUBE.performance->>'watsourcewasteinternaltotal')::numeric AS watsourcewasteinternaltotal,

    (CUBE.performance->>'finalProductAssembly_water_l')::numeric AS finalProductAssembly_water_l,
    (CUBE.performance->>'printingProductDyeingAndLaundering_water_l')::numeric AS printingProductDyeingAndLaundering_water_l,
    (CUBE.performance->>'hardComponentTrimProduction_water_l')::numeric AS hardComponentTrimProduction_water_l,
    (CUBE.performance->>'materialProduction_water_l')::numeric AS materialProduction_water_l,
    (CUBE.performance->>'rawMaterialProcessing_water_l')::numeric AS rawMaterialProcessing_water_l,
    (CUBE.performance->>'rawMaterialCollection_water_l')::numeric AS rawMaterialCollection_water_l,

    (CUBE.performance->>'watsourcerecycled')::numeric AS watsourcerecycled, --recycled sources
    (CUBE.performance->>'watsourcewithdrawal')::numeric AS watsourcewithdrawal, --withdrawal sources,

    (CUBE.performance->>'water_intensity_l_pc')::numeric AS water_intensity_l_pc,
    (CUBE.performance->>'water_intensity_l_kg')::numeric AS water_intensity_l_kg,    

    (CUBE.performance->>'blue_water_use')::numeric AS blue_water_use,
    (CUBE.performance->>'grey_water_use')::numeric AS grey_water_use,
    (CUBE.performance->>'production_water_use')::numeric AS production_water_use,
    (CUBE.performance->>'domestic_total_water_l')::numeric AS domestic_total_water_l,

    CUBE.performance->>'watriskrating' AS watriskrating,
    CUBE.performance->>'watgroundlegalreqlimit' AS watgroundlegalreqlimit,
    CUBE.performance->>'watgroundlegalreq' AS watgroundlegalreq,
    CUBE.performance->>'watmonitorleaks' AS watmonitorleaks,
    CUBE.performance->>'watbalanceanalysis' AS watbalanceanalysis,
    CUBE.performance->>'wataudit' AS wataudit,
    CUBE.performance->>'watbaselineset' AS watbaselineset,
    CUBE.performance->>'watbaselinesepdomprod' AS watbaselinesepdomprod,
    CUBE.performance->>'wattargetoptblue' AS wattargetoptblue,
    CUBE.performance->>'wattargetoptgrey' AS wattargetoptgrey,
    CUBE.performance->>'watimproverainharvesting' AS watimproverainharvesting,
    CUBE.performance->>'watimproveplan' AS watimproveplan,
    CUBE.performance->>'watimproveopt' AS watimproveopt,
    CUBE.performance->>'watimproveoptgrey' AS watimproveoptgrey,
    CUBE.performance->>'watgroundelim' AS watgroundelim,
    CUBE.performance->>'watbluereducedemonstrate' AS watbluereducedemonstrate,
    (CUBE.performance->>'watbluereducepct')::numeric AS watbluereducepct,
    (CUBE.performance->>'watbluereduceqty')::numeric AS watbluereduceqty,
    CUBE.performance->>'watriskdisclosure' AS watriskdisclosure,
    CUBE.performance->>'watdemonstratepositiveimpact' AS watdemonstratepositiveimpact,
    CUBE.performance->>'watleadingtech' AS watleadingtech,
    CUBE.performance->>'watsbt' AS watsbt,

    --SIP & EMS
    CUBE.performance->>'sipindustryprograms' AS sipindustryprograms,
	CUBE.performance->>'sipindustryprogramsselect' AS sipindustryprogramsselect,
    CUBE.performance->>'sipincludedindiscolsure' AS sipincludedindiscolsure,
    CUBE.performance->>'sipdisclosureplatforms' AS sipdisclosureplatforms,
    CUBE.performance->>'emsmgmt' AS emsmgmt,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsmgmt1topic') AS element) AS emsmgmt1topic,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsmgmt2topic') AS element) AS emsmgmt2topic,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsmgmt3topic') AS element) AS emsmgmt3topic,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsmgmt4topic') AS element) AS emsmgmt4topic,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsmgmt5topic') AS element) AS emsmgmt5topic,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsmgmt6topic') AS element) AS emsmgmt6topic,
	CUBE.performance->>'emsenvpolicy' AS emsenvpolicy,
	CUBE.performance->>'emsequipmaintain' AS emsequipmaintain,
	CUBE.performance->>'emsstrategy' AS emsstrategy,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsstrategytopics') AS element) AS emsstrategytopics,
	CUBE.performance->>'emsopsimpact' AS emsopsimpact,
	CUBE.performance->>'emsreportretaliation' AS emsreportretaliation,
	CUBE.performance->>'emsstrategyreview' AS emsstrategyreview,
	CUBE.performance->>'sippermitsreqairemisscompliance' AS sippermitsreqairemisscompliance,
	CUBE.performance->>'sippermitsreqsolidwastecompliance' AS sippermitsreqsolidwastecompliance,
	CUBE.performance->>'integrated_env_permit_status' AS integrated_env_permit_status,
	CUBE.performance->>'sippermitsreqothercompliance' AS sippermitsreqothercompliance,
	CUBE.performance->>'emspermitstatus' AS emspermitstatus,
	CUBE.performance->>'emsregulationsystem' AS emsregulationsystem,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'emsregulationsystemtopics') AS element) AS emsregulationsystemtopics,
	CUBE.performance->>'aircompliance' AS aircompliance,
	CUBE.performance->>'airmonitor' AS airmonitor,
	CUBE.performance->>'airindustryreq' AS airindustryreq,
	CUBE.performance->>'emstraining' AS emstraining,
	CUBE.performance->>'emsstrategyawareness' AS emsstrategyawareness,
	CUBE.performance->>'emshiggindexsubcontract' AS emshiggindexsubcontract,
	CUBE.performance->>'emshiggindexupstream' AS emshiggindexupstream,
	CUBE.performance->>'emsengagelocal' AS emsengagelocal,
	CUBE.performance->>'watreduceplan' AS watreduceplan,
	CUBE.performance->>'waterseparate' AS waterseparate,
	CUBE.performance->>'watsourcetrackoptrejected' AS watsourcetrackoptrejected,
	
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
LEFT JOIN public.fem_shares fs ON fs.assessment_id = CUBE.assessment_id
LEFT JOIN public.account a ON a.account_id = CUBE.account_id
WHERE fs.share_status = 'accepted' AND fs.account_id = '67cf0312482e3b00be3f7574' --12k Large
ORDER BY 1