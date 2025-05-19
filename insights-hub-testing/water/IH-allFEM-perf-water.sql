SELECT
	DISTINCT CUBE.assessment_id AS assessment_id,
	CUBE.status AS status,
	CASE WHEN (((CUBE.facility_posted = TRUE) OR (CUBE.verifier_posted = TRUE)) AND CUBE.status != 'ASD')
		THEN TRUE ELSE FALSE END AS ih_eligible,	
	CUBE.performance->>'rfi_pid' AS rfi_pid,
	CUBE.performance->>'sitecountry' AS sitecountry,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipindustrysector') AS element) AS sipindustrysector,	
	(CUBE.performance->>'sipfulltimeemployees')::numeric AS sipfulltimeemployees,
	
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

    (CUBE.performance->>'total_water_score')::numeric AS total_water_score,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'water_levelsAchieved') AS element) AS water_levelsAchieved,
	CUBE.performance->>'achieved_water_level1' AS achieved_water_level1,
    CUBE.performance->>'sipindustryprograms' AS sipindustryprograms,
	CUBE.performance->>'sipindustryprogramsselect' AS sipindustryprogramsselect,
    (CUBE.performance->>'energy_overall_carbon_intensity')::numeric AS energy_overall_carbon_intensity,
    CUBE.performance->>'ensourcetrackopt' AS ensourcetrackopt,
    CUBE.performance->>'ensourcepurcheac' AS ensourcepurcheac,
    CUBE.performance->>'ensourcepurcheactypes' AS ensourcepurcheactypes,
    (CUBE.performance->>'ensourcepurcheacmwh')::numeric AS ensourcepurcheacmwh,
    CUBE.performance->>'enpurchco' AS enpurchco,
    CUBE.performance->>'enpurchcotypes' AS enpurchcotypes,
    (CUBE.performance->>'enpurchcoquant')::numeric AS enpurchcoquant,
    CUBE.performance->>'enaudit' AS enaudit,
    CUBE.performance->>'enhighestuse' AS enhighestuse,
    CUBE.performance->>'enGHGtarget' AS enGHGtarget,
    CUBE.performance->>'enGHGtargetbaselinequant' AS enGHGtargetbaselinequant,
    CUBE.performance->>'enGHGtargetbaselineyear' AS enGHGtargetbaselineyear,
    CUBE.performance->>'enGHGtargetquant' AS enGHGtargetquant,
    CUBE.performance->>'enGHGtargettargetyear' AS enGHGtargettargetyear,
    CUBE.performance->>'enimproveplan' AS enimproveplan,
    CUBE.performance->>'encoalphaseout' AS encoalphaseout,
	CUBE.performance->>'facility_uses_coal' AS facility_uses_coal,
	(CUBE.performance->>'direct_coal_mj')::NUMERIC AS direct_coal_mj,
	(CUBE.performance->>'direct_coal_kgco2e')::NUMERIC AS direct_coal_kgco2e,
    CUBE.performance->>'encoalphaseoutanalysis' AS encoalphaseoutanalysis,
    CUBE.performance->>'encoalphaseoutdate' AS encoalphaseoutdate,
    CUBE.performance->>'enscope1and2reduction' AS enscope1and2reduction,
    (CUBE.performance->>'enscope1and2reductionquant')::numeric AS enscope1and2reductionquant,
    CUBE.performance->>'enscope1and2reductiontype' AS enscope1and2reductiontype,
    CUBE.performance->>'enimproveopt' AS enimproveopt,
    CUBE.performance->>'enscope3sbti' AS enscope3sbti,
    CUBE.performance->>'enscope3sbtino' AS enscope3sbtino,
    CUBE.performance->>'enscope3sbtimethod' AS enscope3sbtimethod,
    CUBE.performance->>'enscope3sbtiapproved' AS enscope3sbtiapproved,
    CUBE.performance->>'enscope3sbtiplanned' AS enscope3sbtiplanned,
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
	CUBE.performance->>'airleakage' AS airleakage,
	CUBE.performance->>'emsstrategyreview' AS emsstrategyreview,
	CUBE.performance->>'airpolicies' AS airpolicies,
	CUBE.performance->>'sippermitsreqairemisscompliance' AS sippermitsreqairemisscompliance,
	CUBE.performance->>'air_fugitive_permit_status' AS air_fugitive_permit_status,
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
	CUBE.performance->>'ensourcetrackopteach' AS ensourcetrackopteach,
	CUBE.performance->>'ensourcevehicletrackopt' AS ensourcevehicletrackopt,
	CUBE.performance->>'airrefrigerant' AS airrefrigerant,
	CUBE.performance->>'airrefrigtrack' AS airrefrigtrack,
	CUBE.performance->>'airsourceinvent' AS airsourceinvent,
	CUBE.performance->>'airmobile' AS airmobile,
	CUBE.performance->>'airpollutanttrack' AS airpollutanttrack,
	CUBE.performance->>'airproduction' AS airproduction,
	CUBE.performance->>'enscope3ghg' AS enscope3ghg,
	(CUBE.performance->>'ghg_scope_3_co2e')::numeric AS ghg_scope_3_co2e,
	CUBE.performance->>'enbaselinesource' AS enbaselinesource,
	CUBE.performance->>'entargetssource' AS entargetssource,
	CUBE.performance->>'enfossilphaseout' AS enfossilphaseout,
	CUBE.performance->>'enfossilphaseoutanalysis' AS enfossilphaseoutanalysis,
	CUBE.performance->>'enfossilphaseoutwhich' AS enfossilphaseoutwhich,
	CUBE.performance->>'enfossilphaseoutdate' AS enfossilphaseoutdate,
	CUBE.performance->>'airreduce' AS airreduce,
	CUBE.performance->>'airreduceprocess' AS airreduceprocess,
	CUBE.performance->>'airreducepollutant' AS airreducepollutant,
	CUBE.performance->>'airimplementation' AS airimplementation,
	CUBE.performance->>'airimplementationdevices' AS airimplementationdevices,
	CUBE.performance->>'airreplace' AS airreplace,
	CUBE.performance->>'enfossilphaseoutsucc' AS enfossilphaseoutsucc,
	CUBE.performance->>'enfossilphaseoutsuccwhich' AS enfossilphaseoutsuccwhich,
	CUBE.performance->>'airplan' AS airplan,
	CUBE.performance->>'airprogress' AS airprogress,
	CUBE.performance->>'airreplacelegal' AS airreplacelegal,
	CUBE.performance->>'airtech' AS airtech,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipproductcategories') AS element) AS sipproductcategories,
	-- CASE WHEN (CUBE.performance->>'ensourcetotal')::numeric > 1035500000 THEN TRUE ELSE FALSE END AS outlier
	
	CASE WHEN (
        ((CUBE.performance->>'ensourcetotal')::numeric > 1035500000)
        OR ((CUBE.performance->>'finalProductAssemblytotalmj')::numeric > 218000000)
        OR ((CUBE.performance->>'hardComponentTrimProductiontotalmj')::numeric > 198000000)
        OR ((CUBE.performance->>'materialProductiontotalmj')::numeric > 1059500000)
        OR ((CUBE.performance->>'printingProductDyeingAndLaunderingtotalmj')::numeric > 645000000)
        OR ((CUBE.performance->>'rawMaterialProcessingtotalmj')::numeric > 660000000)
        OR ((CUBE.performance->>'rawMaterialCollectiontotalmj')::numeric > 660000000)
        OR ((CUBE.performance->>'domestic_total_mj')::numeric > 64500000)
        OR (((CUBE.performance->>'finalProductAssemblytotalmj')::numeric) / NULLIF((CUBE.performance->>'finalProductAssemblytotal')::numeric, 0) > 810)
        OR (((CUBE.performance->>'hardComponentTrimProductiontotalmj')::numeric) / NULLIF((CUBE.performance->>'hardComponentTrimProductiontotal')::numeric, 0) > 870)
        OR (((CUBE.performance->>'materialProductiontotalmj')::numeric) / NULLIF((CUBE.performance->>'materialProductiontotal')::numeric, 0) > 405)
        OR (((CUBE.performance->>'printingProductDyeingAndLaunderingtotalmj')::numeric) / NULLIF((CUBE.performance->>'printingProductDyeingAndLaunderingtotal')::numeric, 0) > 1755)
        OR (((CUBE.performance->>'rawMaterialProcessingtotalmj')::numeric) / NULLIF((CUBE.performance->>'rawMaterialProcessingtotal')::numeric, 0) > 270)
        OR (((CUBE.performance->>'rawMaterialCollectiontotalmj')::numeric) / NULLIF((CUBE.performance->>'rawMaterialCollectiontotal')::numeric, 0) > 270)
		OR ((CUBE.performance->>'totalGHGemissions')::numeric < 0)
		OR ((CUBE.performance->>'totalGHGemissions')::numeric > 1000000000000)    
	) 
    THEN TRUE 
    ELSE FALSE 
	END AS outlier,

	-- CUBE.performance ->> 'is_outlier' AS outlier
	-- replace previous outlier logic with line above once Javier pushes updated outlier logic to Staging

	CASE WHEN (CUBE.performance->>'ensourcetotal')::numeric > 38574 THEN TRUE ELSE FALSE END AS meets_energy_threshold

FROM fem_simple CUBE
LEFT JOIN public.fem_shares fs ON fs.assessment_id = CUBE.assessment_id
WHERE CUBE.facility_posted = 'true'
ORDER BY 1