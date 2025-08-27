SELECT
    -- Metadata
	CUBE.assessment_id AS assessment_id,
    a.name AS account_name,
	CUBE.status AS status,
	CASE WHEN (((CUBE.facility_posted = TRUE) OR (CUBE.verifier_posted = TRUE)) AND CUBE.status != 'ASD')
		THEN TRUE ELSE FALSE END AS ih_eligible,
    CASE WHEN (CUBE.status = 'VRF'AND CUBE.verifier_posted = TRUE) THEN TRUE ELSE FALSE END AS verified,
	CUBE.performance->>'rfi_pid' AS rfi_pid,
	CUBE.performance->>'sitecountry' AS sitecountry,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipindustrysector') AS element) AS sipindustrysector,	

    -- Emission totals
	(CUBE.performance->>'totalGHGemissions')::numeric AS totalGHGemissions,
    (CUBE.performance->>'totalRefrigerantEmissions')::numeric AS totalRefrigerantEmissions,
	
    -- Facility type
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

    -- Scores
    CASE WHEN (CUBE.performance->>'total_score')::numeric IS NULL THEN 0 ELSE (CUBE.performance->>'total_score')::numeric END AS total_score,
    (CUBE.performance->>'total_ems_score')::numeric AS total_ems_score,
    (CUBE.performance->>'total_energy_score')::numeric AS total_energy_score,
    (CUBE.performance->>'total_water_score')::numeric AS total_water_score,
    (CUBE.performance->>'total_wastewater_score')::numeric AS total_wastewater_score,
    (CUBE.performance->>'total_air_score')::numeric AS total_air_score,
    (CUBE.performance->>'total_waste_score')::numeric AS total_waste_score,
    (CUBE.performance->>'total_chemicals_score')::numeric AS total_chemicals_score,

    -- Levels
    (CUBE.performance->>'achieved_energy_level1')::boolean AS achieved_energy_level1,
    (CUBE.performance->>'achieved_water_level1')::boolean AS achieved_water_level1,
    (CUBE.performance->>'achieved_waste_level1')::boolean AS achieved_waste_level1,
    (CUBE.performance->>'achieved_ems_level1')::boolean AS achieved_ems_level1,
    (CUBE.performance->>'achieved_air_level1')::boolean AS achieved_air_level1,
    (CUBE.performance->>'achieved_chem_level1')::boolean AS achieved_chem_level1,
    (CUBE.performance->>'achieved_ww_level1')::boolean AS achieved_ww_level1,
    CASE WHEN(
        (CUBE.performance->>'achieved_energy_level1')::boolean = TRUE
        AND (CUBE.performance->>'achieved_water_level1')::boolean = TRUE
        AND (CUBE.performance->>'achieved_waste_level1')::boolean = TRUE
        AND (CUBE.performance->>'achieved_ems_level1')::boolean = TRUE
        AND (CUBE.performance->>'achieved_air_level1')::boolean = TRUE
        AND (CUBE.performance->>'achieved_chem_level1')::boolean = TRUE
        AND (CUBE.performance->>'achieved_ww_level1')::boolean = TRUE
    ) THEN TRUE ELSE FALSE END AS achieved_all_level1,
    
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'energy_levelsAchieved') AS element) AS energy_levels_achieved,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'water_levelsAchieved') AS element) AS water_levels_achieved,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'waste_levelsAchieved') AS element) AS waste_levels_achieved,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'ems_levelsAchieved') AS element) AS ems_levels_achieved,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'air_levelsAchieved') AS element) AS air_levels_achieved,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'chemicals_levelsAchieved') AS element) AS chem_levels_achieved,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'wastewater_levelsAchieved') AS element) AS wastewater_levels_achieved,

    -- Audit data
    CUBE.performance->>'sipaudit' AS sipaudit,
    (CUBE.performance->>'sipauditlength')::numeric AS sipauditlength,
    CASE WHEN (CUBE.performance->>'sipauditnumber')::numeric IS NULL THEN 0 ELSE (CUBE.performance->>'sipauditnumber')::numeric END AS sipauditnumber,

    -- Operating data
    (CUBE.performance->>'sipoperatingdays')::numeric AS sipoperatingdays,
    (CUBE.performance->>'sipfulltimeemployees')::numeric AS sipfulltimeemployees,
    (CUBE.performance->>'siptempemployees')::numeric AS siptempemployees,

    -- Training & SIP
    CUBE.performance->>'sipapprovedtraining' AS sipapprovedtraining,
    CUBE.performance->>'sipapprovedtrainingname' AS sipapprovedtrainingname,
    CUBE.performance->>'sipapprovedtrainingyear' AS sipapprovedtrainingyear,
    CUBE.performance->>'sipapprovedtrainer' AS sipapprovedtrainer,
    CUBE.performance->>'sipapprovedtrainingref' AS sipapprovedtrainingref,
    CUBE.performance->>'sipapprovedtrainingcount' AS sipapprovedtrainingcount,
    CUBE.performance->>'sipincludedindiscolsure' AS sipincludedindiscolsure,
    CUBE.performance->>'sip_has_osh_id' AS sip_has_osh_id,
    CUBE.performance->>'sip_osh_id' AS sip_osh_id,
    CUBE.performance->>'valid_operating_license' AS valid_operating_license,
    CUBE.performance->>'government_violation' AS government_violation,
    CUBE.performance->>'sipgovenvviolation2018desc' AS sipgovenvviolation2018desc,
    CUBE.performance->>'ipe_records' AS ipe_records,

    -- Permits & Compliance
    CUBE.performance->>'permit_compliance_wateruse' AS permit_compliance_wateruse,
    CUBE.performance->>'permit_compliance_ww_direct' AS permit_compliance_ww_direct,
    CUBE.performance->>'permit_compliance_ww_indirect' AS permit_compliance_ww_indirect,
    CUBE.performance->>'permit_compliance_wwtreat_direct' AS permit_compliance_wwtreat_direct,
    CUBE.performance->>'permit_compliance_wwtreat_indirect' AS permit_compliance_wwtreat_indirect,
    CUBE.performance->>'permit_compliance_chemuse' AS permit_compliance_chemuse,
    CUBE.performance->>'permit_compliance_airemiss_supply' AS permit_compliance_airemiss_supply,
    CUBE.performance->>'permit_compliance_airemiss_process' AS permit_compliance_airemiss_process,
    CUBE.performance->>'permit_compliance_solidwaste' AS permit_compliance_solidwaste,
    CUBE.performance->>'permit_compliance_int_env' AS permit_compliance_int_env,
    CUBE.performance->>'permit_compliance_other' AS permit_compliance_other,

    -- Energy
    CUBE.performance->>'energylevel2opt' AS energylevel2opt,
    CUBE.performance->>'ensourcetrackopt' AS ensourcetrackopt,
    CUBE.performance->>'ensourcetrackopteach' AS ensourcetrackopteach,
    CUBE.performance->>'ensourcetracksepdomprod' AS ensourcetracksepdomprod,
    CUBE.performance->>'ensourcevehicletrackopt' AS ensourcevehicletrackopt,
    CUBE.performance->>'ensourcevehicle' AS ensourcevehicle,

    -- Water
    CUBE.performance->>'watlevel2opt' AS watlevel2opt,
    CUBE.performance->>'app_water' AS app_water,
    (CASE WHEN
        CUBE.performance->>'app_water' ILIKE '%highRisk%'
        THEN TRUE
    ELSE FALSE END)::boolean AS app_water_high_risk,
    CUBE.performance->>'watsourcetrackopt' AS watsourcetrackopt,
    CUBE.performance->>'watsourcetrackoptall' AS watsourcetrackoptall,
    CUBE.performance->>'wattrackdomprodsep' AS wattrackdomprodsep,
    CUBE.performance->>'watsource' AS watsource,
    CUBE.performance->>'watgroundlegalreq' AS watgroundlegalreq,
    CUBE.performance->>'watgroundlegalreqlimit' AS watgroundlegalreqlimit,
    CUBE.performance->>'watmonitorleaks' AS watmonitorleaks,

    -- Wastewater
    CUBE.performance->>'wwlevel2opt' AS wwlevel2opt,
    CUBE.performance->>'wwtrackopt' AS wwtrackopt,
    CUBE.performance->>'wwmonitorbod5' AS wwmonitorbod5,
    CUBE.performance->>'wwstormwatermixing' AS wwstormwatermixing,
    CUBE.performance->>'wwoffsitetreatplantcontract' AS wwoffsitetreatplantcontract,
    CUBE.performance->>'wwfunction' AS wwfunction,
    CUBE.performance->>'wwemergplan' AS wwemergplan,
    CUBE.performance->>'wwleaking' AS wwleaking,
    CUBE.performance->>'wwsludgereporting' AS wwsludgereporting,
    CUBE.performance->>'wwsludgedomesticreporting' AS wwsludgedomesticreporting,
    CUBE.performance->>'wwsludgestorage' AS wwsludgestorage,
    CUBE.performance->>'wwhsludgedisposal' AS wwhsludgedisposal,
    CUBE.performance->>'wwsludge' AS wwsludge,
    CUBE.performance->>'wwsludgetraining' AS wwsludgetraining,
    CUBE.performance->>'wwnhsludgedisposal' AS wwnhsludgedisposal,
    CUBE.performance->>'wwsepticwater' AS wwsepticwater,
    CUBE.performance->>'wwtestlegal' AS wwtestlegal,
    CUBE.performance->>'wwstandard' AS wwstandard,

    -- Air
    CUBE.performance->>'airlevel2opt' AS airlevel2opt,
    CUBE.performance->>'app_air' AS app_air,
    (CASE WHEN
        (CUBE.performance->>'app_air' ILIKE '%prod%'
            OR CUBE.performance->>'app_air' ILIKE '%allWithRefrigerant%')
        THEN TRUE
    ELSE FALSE END)::boolean AS app_air_prod,    
    CUBE.performance->>'airsourceinvent' AS airsourceinvent,
    CUBE.performance->>'airmobile' AS airmobile,
    CUBE.performance->>'aircompliance' AS aircompliance,
    CUBE.performance->>'airrefrigerant' AS airrefrigerant,
    CUBE.performance->>'airleakage' AS airleakage,
    CUBE.performance->>'airrefrigtrack' AS airrefrigtrack,
    CUBE.performance->>'airmonitor' AS airmonitor,

    -- Waste
    CUBE.performance->>'wastelevel2opt' AS wastelevel2opt,
    CUBE.performance->>'wstsourcenhtrack' AS wstsourcenhtrack,
    CUBE.performance->>'wstsourcetotalnonhaz' AS wstsourcetotalnonhaz,
    CUBE.performance->>'wstsourceeach' AS wstsourceeach,
    CUBE.performance->>'wstsourcehtrack' AS wstsourcehtrack,
    CUBE.performance->>'wstsourcetotalhaz' AS wstsourcetotalhaz,
    CUBE.performance->>'wstsourcehtrackeach' AS wstsourcehtrackeach,
    CUBE.performance->>'wstsegregatestreams' AS wstsegregatestreams,
    CUBE.performance->>'wsthstorage' AS wsthstorage,
    CUBE.performance->>'wstnhstorage' AS wstnhstorage,
    CUBE.performance->>'wstpolburn' AS wstpolburn,
    CUBE.performance->>'wsttraining' AS wsttraining,
    CUBE.performance->>'wsthtrain' AS wsthtrain,

    -- EMS (Environmental Management System)
    CUBE.performance->>'emslevel2opt' AS emslevel2opt,
    CUBE.performance->>'emsmgmt' AS emsmgmt,
    CUBE.performance->>'emsopsimpact' AS emsopsimpact,
    CUBE.performance->>'emsenvpolicy' AS emsenvpolicy,
    CUBE.performance->>'emsstrategy' AS emsstrategy,
    CUBE.performance->>'emsstrategytopics' AS emsstrategytopics,
    CUBE.performance->>'emspermitstatus' AS emspermitstatus,
    CUBE.performance->>'emsregulationsystem' AS emsregulationsystem,
    CUBE.performance->>'emstraining' AS emstraining,
    CUBE.performance->>'emstrainingcount' AS emstrainingcount,
    CUBE.performance->>'emstrainingfreq' AS emstrainingfreq,
    CUBE.performance->>'emstrainingeval' AS emstrainingeval,
    CUBE.performance->>'emstrainingevalhow' AS emstrainingevalhow,
    CUBE.performance->>'emsreportretaliation' AS emsreportretaliation,
    CUBE.performance->>'emsequipmaintain' AS emsequipmaintain,
    CUBE.performance->>'emscontamination' AS emscontamination,
    CUBE.performance->>'emscontaminationprevent' AS emscontaminationprevent,
    CUBE.performance->>'emscontaminationremediation' AS emscontaminationremediation,
    CUBE.performance->>'emscontaminationdesc' AS emscontaminationdesc,
    CUBE.performance->>'emsdataqualitymanagementsystem' AS emsdataqualitymanagementsystem,
    CUBE.performance->>'emsdataqualitymanagementsystemmetrics' AS emsdataqualitymanagementsystemmetrics,

    -- Chemicals
    CUBE.performance->>'chemlevel2opt' AS chemlevel2opt,
    CUBE.performance->>'app_chem_type' AS app_chem_type,
    (CASE WHEN
        CUBE.performance->>'app_chem_type' ILIKE '%minimumchemicaluse%'
        THEN TRUE
    ELSE FALSE END)::boolean AS app_chem_minimal,
    CUBE.performance->>'chemcmspolicynonprod' AS chemcmspolicynonprod,
    CUBE.performance->>'chemcmspolicyprod' AS chemcmspolicyprod,
    CUBE.performance->>'chemcmstraining' AS chemcmstraining,
    CUBE.performance->>'chempurchasingpolicy' AS chempurchasingpolicy,
    CUBE.performance->>'chemtrack' AS chemtrack,
    CUBE.performance->>'chemtrackdata_name' AS chemtrackdata_name,
    CUBE.performance->>'chemtrackdata_vendor' AS chemtrackdata_vendor,
    CUBE.performance->>'chemtrackdata_manufacturer' AS chemtrackdata_manufacturer,
    CUBE.performance->>'chemtrackdata_sds' AS chemtrackdata_sds,
    CUBE.performance->>'chemtrackdata_function' AS chemtrackdata_function,
    CUBE.performance->>'chemtrackdata_hazard' AS chemtrackdata_hazard,
    CUBE.performance->>'chemtrackdata_where_used' AS chemtrackdata_where_used,
    CUBE.performance->>'chemtrackdata_storage' AS chemtrackdata_storage,
    CUBE.performance->>'chemtrackdata_quantities' AS chemtrackdata_quantities,
    CUBE.performance->>'chemtrackdata_cas' AS chemtrackdata_cas,
    CUBE.performance->>'chemtrackdata_lot' AS chemtrackdata_lot,
    CUBE.performance->>'chemtrackdata_mrsl' AS chemtrackdata_mrsl,
    CUBE.performance->>'chemtrackdata_purchase_date' AS chemtrackdata_purchase_date,
    CUBE.performance->>'chemtrackdata_expiry' AS chemtrackdata_expiry,
    CUBE.performance->>'chemsds' AS chemsds,
    CUBE.performance->>'chemtraining' AS chemtraining,
    CUBE.performance->>'chememergplan' AS chememergplan,
    CUBE.performance->>'chemsafetyequip' AS chemsafetyequip,
    CUBE.performance->>'chemhazardsign' AS chemhazardsign,
    CUBE.performance->>'chempurchasereqmrsl' AS chempurchasereqmrsl,
    CUBE.performance->>'chempurchasereqrsl' AS chempurchasereqrsl,
    CUBE.performance->>'chemhealthprogram' AS chemhealthprogram,
    CUBE.performance->>'chemstorage' AS chemstorage,
    CUBE.performance->>'chemsubstorage' AS chemsubstorage,
    CUBE.performance->>'chemtrainingr' AS chemtrainingr,
    CUBE.performance->>'chemtrainingm' AS chemtrainingm,
    CUBE.performance->>'chemfailresolution' AS chemfailresolution

FROM fem_simple CUBE
LEFT JOIN public.fem_shares fs ON fs.assessment_id = CUBE.assessment_id
LEFT JOIN public.account a ON a.account_id = CUBE.account_id
WHERE fs.share_status = 'accepted' AND fs.account_id = '67cf0312482e3b00be3f7574'
    AND CUBE.performance->>'rfi_pid' IN ('fem2022','fem2023','fem2024')
ORDER BY 1