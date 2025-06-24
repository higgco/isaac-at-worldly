SELECT
	DISTINCT CUBE.assessment_id AS assessment_id,
	CUBE.status AS status,
	CASE WHEN (((CUBE.facility_posted = TRUE) OR (CUBE.verifier_posted = TRUE)) AND CUBE.status != 'ASD')
		THEN TRUE ELSE FALSE END AS ih_eligible,	
	CUBE.performance->>'rfi_pid' AS rfi_pid,
	CUBE.performance->>'sitecountry' AS sitecountry,

	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipindustrysector') AS element) AS sipindustrysector,	
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipproductcategories') AS element) AS sipproductcategories,

	(CUBE.performance->>'sipfulltimeemployees')::numeric AS sipfulltimeemployees,

    (CUBE.performance->>'total_waste_score')::numeric AS total_waste_score,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'waste_levelsAchieved') AS element) AS waste_levelsAchieved,
	CUBE.performance->>'achieved_waste_level1' AS achieved_waste_level1,
	
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

    --Sources
	CUBE.performance->>'wstsourcenhtrack' AS wstsourcenhtrack,
	CUBE.performance->>'wstsourceeach' AS wstsourceeach,
	CUBE.performance->>'wstsourcehtrack' AS wstsourcehtrack,
	CUBE.performance->>'wstsourcehtrackeach' AS wstsourcehtrackeach,
	
    (CUBE.performance->>'wstsourcetotalnonhaz')::numeric AS wstsourcetotalnonhaz,
    (CUBE.performance->>'wstsourcetotalhaz')::numeric AS wstsourcetotalhaz,
    (CUBE.performance->>'wstsourcetotal')::numeric AS wstsourcetotal,
	
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'wstsourcenh') AS element) AS wstsourcenh,
	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'wstsourceh') AS element) AS wstsourceh,
	
	(CUBE.performance->>'wstsourcenhmaterialstotal')::numeric AS wstsourcenhmaterialstotal,
	(CUBE.performance->>'wstsourcenhmetaltotal')::numeric AS wstsourcenhmetaltotal,
	(CUBE.performance->>'wstsourcenhplastictotal')::numeric AS wstsourcenhplastictotal,
	(CUBE.performance->>'wstsourcenhpapertotal')::numeric AS wstsourcenhpapertotal,
	(CUBE.performance->>'wstsourcenhcanstotal')::numeric AS wstsourcenhcanstotal,
	(CUBE.performance->>'wstsourcenhfoodtotal')::numeric AS wstsourcenhfoodtotal,
	(CUBE.performance->>'wstsourcenhglasstotal')::numeric AS wstsourcenhglasstotal,
	(CUBE.performance->>'wstsourcenhcartonstotal')::numeric AS wstsourcenhcartonstotal,
	(CUBE.performance->>'wstsourcenhothertotal')::numeric AS wstsourcenhothertotal,
	(CUBE.performance->>'wstsourcenhtotaldomtotal')::numeric AS wstsourcenhtotaldomtotal,
	(CUBE.performance->>'wstsourcenhtextiletotal')::numeric AS wstsourcenhtextiletotal,
	(CUBE.performance->>'wstsourcenhleathertotal')::numeric AS wstsourcenhleathertotal,
	(CUBE.performance->>'wstsourcenhrubbertotal')::numeric AS wstsourcenhrubbertotal,
	(CUBE.performance->>'wstsourcenhwoodtotal')::numeric AS wstsourcenhwoodtotal,
	(CUBE.performance->>'wstsourcenhfoamstotal')::numeric AS wstsourcenhfoamstotal,
	(CUBE.performance->>'wstsourcenhwastewaterTreatmentSludgetotal')::numeric AS wstsourcenhwastewaterTreatmentSludgetotal,
	(CUBE.performance->>'wstsourcenhgeneral')::numeric AS wstsourcenhgeneral,
	(CUBE.performance->>'wstsourcenhslag')::numeric AS wstsourcenhslag,
	(CUBE.performance->>'wstsourcehprodchemdrumtotal')::numeric AS wstsourcehprodchemdrumtotal,
	(CUBE.performance->>'wstsourcehprodfilmprinttotal')::numeric AS wstsourcehprodfilmprinttotal,
	(CUBE.performance->>'wstsourcehprodsludgetotal')::numeric AS wstsourcehprodsludgetotal,
	(CUBE.performance->>'wstsourcehprodchemtotal')::numeric AS wstsourcehprodchemtotal,
	(CUBE.performance->>'wstsourcehprodcompgastotal')::numeric AS wstsourcehprodcompgastotal,
	(CUBE.performance->>'wstsourcehprodcontammattotal')::numeric AS wstsourcehprodcontammattotal,
	(CUBE.performance->>'wstsourcehdombatteriestotal')::numeric AS wstsourcehdombatteriestotal,
	(CUBE.performance->>'wstsourcehdomflolighttotal')::numeric AS wstsourcehdomflolighttotal,
	(CUBE.performance->>'wstsourcehdominkcarttotal')::numeric AS wstsourcehdominkcarttotal,
	(CUBE.performance->>'wstsourcehdomoilgreasetotal')::numeric AS wstsourcehdomoilgreasetotal,
	(CUBE.performance->>'wstsourcehdomemptyconttotal')::numeric AS wstsourcehdomemptyconttotal,
	(CUBE.performance->>'wstsourcehdomelectronictotal')::numeric AS wstsourcehdomelectronictotal,
	(CUBE.performance->>'wstsourcehdomcoalcombtotal')::numeric AS wstsourcehdomcoalcombtotal,
	(CUBE.performance->>'wstsourcehothertotal')::numeric AS wstsourcehothertotal,
	(CUBE.performance->>'wstsourcehproductionoiltotal')::numeric AS wstsourcehproductionoiltotal,
	(CUBE.performance->>'wstsourcehmetalsludgetotal')::numeric AS wstsourcehmetalsludgetotal,
	(CUBE.performance->>'wstsourcehslagtotal')::numeric AS wstsourcehslagtotal,

	(CUBE.performance->>'reuse_nh_kg')::numeric AS reuse_nh_kg,
	(CUBE.performance->>'upcycle_nh_kg')::numeric AS upcycle_nh_kg,
	(CUBE.performance->>'recycle_nh_kg')::numeric AS recycle_nh_kg,
	(CUBE.performance->>'downcycling_nh_kg')::numeric AS downcycling_nh_kg,
	(CUBE.performance->>'material_nh_kg')::numeric AS material_nh_kg,
	(CUBE.performance->>'energy_nh_kg')::numeric AS energy_nh_kg,
	(CUBE.performance->>'residual_nh_kg')::numeric AS residual_nh_kg,
	(CUBE.performance->>'onsite_nh_kg')::numeric AS onsite_nh_kg,
	(CUBE.performance->>'offsite_nh_kg')::numeric AS offsite_nh_kg,
	(CUBE.performance->>'othertreatment_nh_kg')::numeric AS othertreatment_nh_kg,
	(CUBE.performance->>'landfill_nh_kg')::numeric AS landfill_nh_kg,
	(CUBE.performance->>'energyrecovery_nh_kg')::numeric AS energyrecovery_nh_kg,
	(CUBE.performance->>'nocontrol_nh_kg')::numeric AS nocontrol_nh_kg,
	(CUBE.performance->>'onsitenoenergy_nh_kg')::numeric AS onsitenoenergy_nh_kg,
	(CUBE.performance->>'offsitenoenergy_nh_kg')::numeric AS offsitenoenergy_nh_kg,
	(CUBE.performance->>'other_nh_kg')::numeric AS other_nh_kg,
	(CUBE.performance->>'multiple_disposal_nh_kg')::numeric AS multiple_disposal_nh_kg,
	(CUBE.performance->>'reuse_h_kg')::numeric AS reuse_h_kg,
	(CUBE.performance->>'upcycle_h_kg')::numeric AS upcycle_h_kg,
	(CUBE.performance->>'recycle_h_kg')::numeric AS recycle_h_kg,
	(CUBE.performance->>'downcycling_h_kg')::numeric AS downcycling_h_kg,
	(CUBE.performance->>'material_h_kg')::numeric AS material_h_kg,
	(CUBE.performance->>'energy_h_kg')::numeric AS energy_h_kg,
	(CUBE.performance->>'residual_h_kg')::numeric AS residual_h_kg,
	(CUBE.performance->>'onsite_h_kg')::numeric AS onsite_h_kg,
	(CUBE.performance->>'offsite_h_kg')::numeric AS offsite_h_kg,
	(CUBE.performance->>'othertreatment_h_kg')::numeric AS othertreatment_h_kg,
	(CUBE.performance->>'landfill_h_kg')::numeric AS landfill_h_kg,
	(CUBE.performance->>'energyrecovery_h_kg')::numeric AS energyrecovery_h_kg,
	(CUBE.performance->>'nocontrol_h_kg')::numeric AS nocontrol_h_kg,
	(CUBE.performance->>'onsitenoenergy_h_kg')::numeric AS onsitenoenergy_h_kg,
	(CUBE.performance->>'offsitenoenergy_h_kg')::numeric AS offsitenoenergy_h_kg,
	(CUBE.performance->>'other_h_kg')::numeric AS other_h_kg,
	(CUBE.performance->>'multiple_disposal_h_kg')::numeric AS multiple_disposal_h_kg,

    CUBE.performance->>'wstsegregatestreams' AS wstsegregatestreams,
	CUBE.performance->>'wstnhstorage' AS wstnhstorage,
	CUBE.performance->>'wsthstorage' AS wsthstorage,
	CUBE.performance->>'wstvalidate1' AS wstvalidate1,
	CUBE.performance->>'wsthazdispvalidate' AS wsthazdispvalidate,
	CUBE.performance->>'wstpolburn' AS wstpolburn,
	CUBE.performance->>'wsttraining' AS wsttraining,
	CUBE.performance->>'wsthtrain' AS wsthtrain,
	CUBE.performance->>'wstbaselinenh' AS wstbaselinenh,
	CUBE.performance->>'wstbaselineh' AS wstbaselineh,
	CUBE.performance->>'wstbaselinedisp' AS wstbaselinedisp,
	CUBE.performance->>'wsttargetnh' AS wsttargetnh,
	CUBE.performance->>'wsttargeth' AS wsttargeth,
	CUBE.performance->>'wsttargetdisp' AS wsttargetdisp,
	CUBE.performance->>'wstredimpnhsource' AS wstredimpnhsource,
	CUBE.performance->>'wstredimphprodsource' AS wstredimphprodsource,
	CUBE.performance->>'wstredimpdisp' AS wstredimpdisp,
	CUBE.performance->>'wstdispzerowaste' AS wstdispzerowaste,
	CUBE.performance->>'wstredimpplan' AS wstredimpplan,
	CUBE.performance->>'wstworkoncircular' AS wstworkoncircular,
	CUBE.performance->>'wstdisposal_reuse' AS wstdisposal_reuse,
	CUBE.performance->>'wstdisposal_recycle_upcycle' AS wstdisposal_recycle_upcycle,
	CUBE.performance->>'wstdisposal_downcycle' AS wstdisposal_downcycle,
	CUBE.performance->>'wstdisposal_energy_incin_nonrecycle' AS wstdisposal_energy_incin_nonrecycle,
	CUBE.performance->>'wstdisposal_energy_residual' AS wstdisposal_energy_residual,
	CUBE.performance->>'wstdisposal_nonval_onsite' AS wstdisposal_nonval_onsite,
	CUBE.performance->>'wstdisposal_nonval_offsite' AS wstdisposal_nonval_offsite,
	CUBE.performance->>'wstdisposal_nonval_other' AS wstdisposal_nonval_other,
	CUBE.performance->>'wstdisposal_nonval_landfill_responsible' AS wstdisposal_nonval_landfill_responsible,
	CUBE.performance->>'wstdisposal_recover_incineration_recycle' AS wstdisposal_recover_incineration_recycle,
	CUBE.performance->>'wstdisposal_landfill' AS wstdisposal_landfill,
	CUBE.performance->>'wstdisposal_onsiteincin_recycle' AS wstdisposal_onsiteincin_recycle,
	CUBE.performance->>'wstdisposal_offisteincin_recycle' AS wstdisposal_offisteincin_recycle,
	CUBE.performance->>'wstdisposal_other' AS wstdisposal_other,

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
	
	CUBE.performance->>'permit_compliance_solidwaste' AS permit_compliance_solidwaste,
	CUBE.performance->>'wstsourcetextile' AS wstsourcetextile

FROM fem_simple CUBE
LEFT JOIN public.fem_shares fs ON fs.assessment_id = CUBE.assessment_id
WHERE fs.share_status = 'accepted' AND fs.account_id = '67cf0312482e3b00be3f7574' --12k Large
ORDER BY 1