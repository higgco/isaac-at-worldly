SELECT
	DISTINCT CUBE.assessment_id AS assessment_id,
	CUBE.status AS status,
	CASE WHEN (((CUBE.facility_posted = TRUE) OR (CUBE.verifier_posted = TRUE)) AND CUBE.status != 'ASD')
		THEN TRUE ELSE FALSE END AS ih_eligible,
	CUBE.performance->>'rfi_pid' AS rfi_pid,

	CUBE.account_id,
	a.name AS account_name,
	a.lat AS account_lat,
	a.long AS account_long,
	CUBE.performance->>'sitecountry' AS sitecountry,

	(SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipindustrysector') AS element) AS sipindustrysector,	
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipproductcategories') AS element) AS sipproductcategories,
	
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

    CUBE.performance->>'airsourceaircon' AS airsourceaircon,
    CUBE.performance->>'airsourceheating' AS airsourceheating,
    CUBE.performance->>'assessment_id' AS assessment_id,
    CUBE.performance->>'enGHGtarget' AS enGHGtarget,
    CUBE.performance->>'entargetssource' AS entargetssource,
    CUBE.performance->>'sipfacilityannualprodvolunits' AS sipfacilityannualprodvolunits,
    CUBE.performance->>'sipindustryprogramsselect' AS sipindustryprogramsselect,
    CUBE.performance->>'sipmaterialinsulations' AS sipmaterialinsulations,
    CUBE.performance->>'sipmaterialmmcf' AS sipmaterialmmcf,
    CUBE.performance->>'sipmaterialsynleathers' AS sipmaterialsynleathers,
    CUBE.performance->>'sipmaterialtype' AS sipmaterialtype,
    CUBE.performance->>'sipmaterialwoodbiomass' AS sipmaterialwoodbiomass,
    CUBE.performance->>'facility_posted' AS facility_posted,
    CUBE.performance->>'verifier_posted' AS verifier_posted,
    CUBE.performance->>'watbluereducedemonstrate' AS watbluereducedemonstrate,
    CUBE.performance->>'watgroundelim' AS watgroundelim,
    CUBE.performance->>'watimproveplan' AS watimproveplan,
    CUBE.performance->>'watproduse' AS watproduse,
    CUBE.performance->>'watreduceplan' AS watreduceplan,
    CUBE.performance->>'wattargetoptblue' AS wattargetoptblue,
    CUBE.performance->>'wattargetoptgrey' AS wattargetoptgrey,
	
    (CUBE.performance->>'enGHGtargetpct')::numeric AS enGHGtargetpct,
    (CUBE.performance->>'ensourcebiodieseltotal')::numeric AS ensourcebiodieseltotal,
    (CUBE.performance->>'ensourcebiodieseltotalghg')::numeric AS ensourcebiodieseltotalghg,
    (CUBE.performance->>'ensourcebiogastotal')::numeric AS ensourcebiogastotal,
    (CUBE.performance->>'ensourcebiogastotalghg')::numeric AS ensourcebiogastotalghg,
    (CUBE.performance->>'ensourcebiomasscerttotal')::numeric AS ensourcebiomasscerttotal,
    (CUBE.performance->>'ensourcebiomasscerttotalghg')::numeric AS ensourcebiomasscerttotalghg,
    (CUBE.performance->>'ensourcebiomassgentotal')::numeric AS ensourcebiomassgentotal,
    (CUBE.performance->>'ensourcebiomassgentotalghg')::numeric AS ensourcebiomassgentotalghg,
    (CUBE.performance->>'ensourcebiomasswoodtotal')::numeric AS ensourcebiomasswoodtotal,
    (CUBE.performance->>'ensourcechilledwatertotal')::numeric AS ensourcechilledwatertotal,
    (CUBE.performance->>'ensourcechilledwatertotalghg')::numeric AS ensourcechilledwatertotalghg,
    (CUBE.performance->>'ensourcecngtotal')::numeric AS ensourcecngtotal,
    (CUBE.performance->>'ensourcecngtotalghg')::numeric AS ensourcecngtotalghg,
    (CUBE.performance->>'ensourcecoaltotalghg')::numeric AS ensourcecoaltotalghg,
    (CUBE.performance->>'ensourcecoalwaterslurrytotal')::numeric AS ensourcecoalwaterslurrytotal,
    (CUBE.performance->>'ensourcecoalwaterslurrytotalghg')::numeric AS ensourcecoalwaterslurrytotalghg,
    (CUBE.performance->>'ensourcedieseltotal')::numeric AS ensourcedieseltotal,
    (CUBE.performance->>'ensourcecoaltotal')::numeric AS ensourcecoaltotal,
    (CUBE.performance->>'ensourcedieseltotalghg')::numeric AS ensourcedieseltotalghg,
    (CUBE.performance->>'ensourcedistrictheatingtotal')::numeric AS ensourcedistrictheatingtotal,
    (CUBE.performance->>'ensourcedistrictheatingtotalghg')::numeric AS ensourcedistrictheatingtotalghg,
    (CUBE.performance->>'ensourceelectricpurchtotal')::numeric AS ensourceelectricpurchtotal,
    (CUBE.performance->>'ensourceelectricpurchtotalghg')::numeric AS ensourceelectricpurchtotalghg,
    (CUBE.performance->>'ensourceethenoltotal')::numeric AS ensourceethenoltotal,
    (CUBE.performance->>'ensourceethenoltotalghg')::numeric AS ensourceethenoltotalghg,
    (CUBE.performance->>'ensourcefabricwastetotal')::numeric AS ensourcefabricwastetotal,
    (CUBE.performance->>'ensourcefabricwastetotalghg')::numeric AS ensourcefabricwastetotalghg,
    (CUBE.performance->>'ensourcefueloiltotal')::numeric AS ensourcefueloiltotal,
    (CUBE.performance->>'ensourcefueloiltotalghg')::numeric AS ensourcefueloiltotalghg,
    (CUBE.performance->>'ensourcegeothermtotal')::numeric AS ensourcegeothermtotal,
    (CUBE.performance->>'ensourcehydrogenrtotal')::numeric AS ensourcehydrogenrtotal,
    (CUBE.performance->>'ensourcehydrototal')::numeric AS ensourcehydrototal,
    (CUBE.performance->>'ensourcelngtotal')::numeric AS ensourcelngtotal,
    (CUBE.performance->>'ensourcelngtotalghg')::numeric AS ensourcelngtotalghg,
    (CUBE.performance->>'ensourcelpgtotal')::numeric AS ensourcelpgtotal,
    (CUBE.performance->>'ensourcelpgtotalghg')::numeric AS ensourcelpgtotalghg,
    (CUBE.performance->>'ensourcemicrohydrototal')::numeric AS ensourcemicrohydrototal,
    (CUBE.performance->>'ensourcenaturalgastotal')::numeric AS ensourcenaturalgastotal,
    (CUBE.performance->>'ensourcenaturalgastotalghg')::numeric AS ensourcenaturalgastotalghg,
    (CUBE.performance->>'ensourcepetroltotal')::numeric AS ensourcepetroltotal,
    (CUBE.performance->>'ensourcepetroltotalghg')::numeric AS ensourcepetroltotalghg,
    (CUBE.performance->>'ensourcepropanetotal')::numeric AS ensourcepropanetotal,
    (CUBE.performance->>'ensourcepropanetotalghg')::numeric AS ensourcepropanetotalghg,
    (CUBE.performance->>'ensourcepurchrenewtotal')::numeric AS ensourcepurchrenewtotal,
    (CUBE.performance->>'ensourcepurchrenewtotalghg')::numeric AS ensourcepurchrenewtotalghg,
    (CUBE.performance->>'ensourcesolarphotototal')::numeric AS ensourcesolarphotototal,
    (CUBE.performance->>'ensourcesolarthermaltotal')::numeric AS ensourcesolarthermaltotal,
    (CUBE.performance->>'ensourcesteampurchtotal')::numeric AS ensourcesteampurchtotal,
    (CUBE.performance->>'ensourcesteampurchtotalghg')::numeric AS ensourcesteampurchtotalghg,
    (CUBE.performance->>'ensourcewindtotal')::numeric AS ensourcewindtotal,
    (CUBE.performance->>'finalProductAssemblytotal')::numeric AS finalProductAssemblytotal,
    (CUBE.performance->>'finalProductAssemblytotalghg')::numeric AS finalProductAssemblytotalghg,
    (CUBE.performance->>'hardComponentTrimProductiontotal')::numeric AS hardComponentTrimProductiontotal,
    (CUBE.performance->>'hardComponentTrimProductiontotalghg')::numeric AS hardComponentTrimProductiontotalghg,
    (CUBE.performance->>'materialProductiontotal')::numeric AS materialProductiontotal,
    (CUBE.performance->>'materialProductiontotalghg')::numeric AS materialProductiontotalghg,
    (CUBE.performance->>'printingProductDyeingAndLaunderingtotal')::numeric AS printingProductDyeingAndLaunderingtotal,
    (CUBE.performance->>'printingProductDyeingAndLaunderingtotalghg')::numeric AS printingProductDyeingAndLaunderingtotalghg,
    (CUBE.performance->>'rawMaterialCollectiontotal')::numeric AS rawMaterialCollectiontotal,
    (CUBE.performance->>'rawMaterialCollectiontotalghg')::numeric AS rawMaterialCollectiontotalghg,
    (CUBE.performance->>'rawMaterialProcessingtotal')::numeric AS rawMaterialProcessingtotal,
    (CUBE.performance->>'rawMaterialProcessingtotalghg')::numeric AS rawMaterialProcessingtotalghg,
    (CUBE.performance->>'sipfacilityannualprodvolquant')::numeric AS sipfacilityannualprodvolquant,
    (CUBE.performance->>'sipfulltimeemployees')::numeric AS sipfulltimeemployees,
    (CUBE.performance->>'sipoperatingdays')::numeric AS sipoperatingdays,
    (CUBE.performance->>'siptempemployees')::numeric AS siptempemployees,
    (CUBE.performance->>'totalGHGemissions')::numeric AS totalGHGemissions,
    (CUBE.performance->>'watsourcegroundtotal')::numeric AS watsourcegroundtotal,
    (CUBE.performance->>'watsourcemunicipalbluetotal')::numeric AS watsourcemunicipalbluetotal,
    (CUBE.performance->>'watsourcemunicipalgreytotal')::numeric AS watsourcemunicipalgreytotal,
    (CUBE.performance->>'watsourcemunicipalunktotal')::numeric AS watsourcemunicipalunktotal,
    (CUBE.performance->>'watsourceraintotal')::numeric AS watsourceraintotal,
    (CUBE.performance->>'watsourcerecycletotal')::numeric AS watsourcerecycletotal,
    (CUBE.performance->>'watsourcereusetotal')::numeric AS watsourcereusetotal,
    (CUBE.performance->>'watsourceseatotal')::numeric AS watsourceseatotal,
    (CUBE.performance->>'watsourcesurfacetotal')::numeric AS watsourcesurfacetotal,
    (CUBE.performance->>'watsourcewastetotal')::numeric AS watsourcewastetotal,

    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityaccessorypc') AS element) AS sipfacilityaccessorypc,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityapparelpc') AS element) AS sipfacilityapparelpc,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityfootwearpc') AS element) AS sipfacilityfootwearpc,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityhardgoodspc') AS element) AS sipfacilityhardgoodspc,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityhomefurnishingpc') AS element) AS sipfacilityhomefurnishingpc,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityhometexpc') AS element) AS sipfacilityhometexpc,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityprocesseschem') AS element) AS sipfacilityprocesseschem,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityprocessesmaterials') AS element) AS sipfacilityprocessesmaterials,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityprocessesprintdye') AS element) AS sipfacilityprocessesprintdye,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityprocessessew') AS element) AS sipfacilityprocessessew,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilityprocessestrim') AS element) AS sipfacilityprocessestrim,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipfacilitytoyspc') AS element) AS sipfacilitytoyspc,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialbarriers') AS element) AS sipmaterialbarriers,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialfoams') AS element) AS sipmaterialfoams,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialinsulation') AS element) AS sipmaterialinsulation,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialleather') AS element) AS sipmaterialleather,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialmetals') AS element) AS sipmaterialmetals,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialplastics') AS element) AS sipmaterialplastics,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialrubbers') AS element) AS sipmaterialrubbers,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialsynthleather') AS element) AS sipmaterialsynthleather,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialtextiles') AS element) AS sipmaterialtextiles,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipmaterialwoodbased') AS element) AS sipmaterialwoodbased,
    (SELECT string_agg(element, ', ') FROM jsonb_array_elements_text(CUBE.performance->'sipproductcategories') AS element) AS sipproductcategories

FROM fem_simple CUBE
LEFT JOIN public.fem_shares fs ON fs.assessment_id = CUBE.assessment_id
LEFT JOIN public.account a ON a.account_id = CUBE.account_id
WHERE fs.share_status = 'accepted' AND fs.account_id = '67cbd154250c3f00fdebbaa4' --900
ORDER BY 1