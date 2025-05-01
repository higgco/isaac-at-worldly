DROP TABLE IF EXISTS isaac_hopwood.fem2023_24_answers_final;

CREATE TABLE isaac_hopwood.fem2023_24_answers_final AS
SELECT
    assessment_id,
	rfi_pid,
    
    answers -> 'wstsourcenhtextiledisposal'->>'response' AS textile_method,
    answers -> 'wstsourcenhtextilequant'->>'response' AS textile_quant,
    answers -> 'wstsourcenhtextileunit'->>'response' AS textile_unit,
    
    answers -> 'wstsourcenhleatherdisposal'->>'response' AS leather_method,
    answers -> 'wstsourcenhleatherquant'->>'response' AS leather_quant,
    answers -> 'wstsourcenhleatherunit'->>'response' AS leather_unit,

    answers -> 'wstsourcenhrubberdisposal'->>'response' AS rubber_method,
    answers -> 'wstsourcenhrubberquant'->>'response' AS rubber_quant,
    answers -> 'wstsourcenhrubberunit'->>'response' AS rubber_unit,

    answers -> 'wstsourcenhmetaldisposal'->>'response' AS metal_method,
    answers -> 'wstsourcenhmetalquant'->>'response' AS metal_quant,
    answers -> 'wstsourcenhmetalunit'->>'response' AS metal_unit,

    answers -> 'wstsourcenhplasticdisposal'->>'response' AS plastic_method,
    answers -> 'wstsourcenhplasticquant'->>'response' AS plastic_quant,
    answers -> 'wstsourcenhplasticunit'->>'response' AS plastic_unit,

    answers -> 'wstsourcenhpaperdisposal'->>'response' AS paper_method,
    answers -> 'wstsourcenhpaperquant'->>'response' AS paper_quant,
    answers -> 'wstsourcenhpaperunit'->>'response' AS paper_unit,

    answers -> 'wstsourcenhcansdisposal'->>'response' AS cans_method,
    answers -> 'wstsourcenhcansquant'->>'response' AS cans_quant,
    answers -> 'wstsourcenhcansunit'->>'response' AS cans_unit,

    answers -> 'wstsourcenhwooddisposal'->>'response' AS wood_method,
    answers -> 'wstsourcenhwoodquant'->>'response' AS wood_quant,
    answers -> 'wstsourcenhwoodunit'->>'response' AS wood_unit,
    
    answers -> 'wstsourcenhfooddisposal'->>'response' AS food_method,
    answers -> 'wstsourcenhfoodquant'->>'response' AS food_quant,
    answers -> 'wstsourcenhfoodunit'->>'response' AS food_unit,

    answers -> 'wstsourcenhglassdisposal'->>'response' AS glass_method,
    answers -> 'wstsourcenhglassquant'->>'response' AS glass_quant,
    answers -> 'wstsourcenhglassunit'->>'response' AS glass_unit,

    answers -> 'wstsourcenhcartonsdisposal'->>'response' AS cartons_method,
    answers -> 'wstsourcenhcartonsquant'->>'response' AS cartons_quant,
    answers -> 'wstsourcenhcartonsunit'->>'response' AS cartons_unit,

    answers -> 'wstsourcenhfoamsdisposal'->>'response' AS foams_method,
    answers -> 'wstsourcenhfoamsquant'->>'response' AS foams_quant,
    answers -> 'wstsourcenhfoamsunit'->>'response' AS foams_unit,

    answers -> 'wstsourcenhwastewaterTreatmentSludgedisposal'->>'response' AS wastewaterTreatmentSludge_method,
    answers -> 'wstsourcenhwastewaterTreatmentSludgequant'->>'response' AS wastewaterTreatmentSludge_quant,
    answers -> 'wstsourcenhwastewaterTreatmentSludgeunit'->>'response' AS wastewaterTreatmentSludge_unit,

    answers -> 'wstsourcenhgeneraldisposal'->>'response' AS nh_general_method,
    answers -> 'wstsourcenhgeneralquant'->>'response' AS nh_general_quant,
    answers -> 'wstsourcenhgeneralunit'->>'response' AS nh_general_unit,

    answers -> 'wstsourcenhslagnhdisposal'->>'response' AS slag_nh_method,
    answers -> 'wstsourcenhslagnhquant'->>'response' AS slag_nh_quant,
    answers -> 'wstsourcenhslagnhunit'->>'response' AS slag_nh_unit,

    answers -> 'wstsourcenhotherdisposal'->>'response' AS nh_other_method,
    answers -> 'wstsourcenhotherquant'->>'response' AS nh_other_quant,
    answers -> 'wstsourcenhotherunit'->>'response' AS nh_other_unit,

    answers -> 'wstsourcehprodchemdrumdisposal'->>'response' AS prodchemdrum_method,
    answers -> 'wstsourcehprodchemdrumquant'->>'response' AS prodchemdrum_quant,
    answers -> 'wstsourcehprodchemdrumunit'->>'response' AS prodchemdrum_unit,

    answers -> 'wstsourcehprodfilmprintdisposal'->>'response' AS prodfilmprint_method,
    answers -> 'wstsourcehprodfilmprintquant'->>'response' AS prodfilmprint_quant,
    answers -> 'wstsourcehprodfilmprintunit'->>'response' AS prodfilmprint_unit,

    answers -> 'wstsourcehprodsludgedisposal'->>'response' AS prodsludge_method,
    answers -> 'wstsourcehprodsludgequant'->>'response' AS prodsludge_quant,
    answers -> 'wstsourcehprodsludgeunit'->>'response' AS prodsludge_unit,

    answers -> 'wstsourcehprodchemdisposal'->>'response' AS prodchem_method,
    answers -> 'wstsourcehprodchemquant'->>'response' AS prodchem_quant,
    answers -> 'wstsourcehprodchemunit'->>'response' AS prodchem_unit,

    answers -> 'wstsourcehprodcompgasdisposal'->>'response' AS prodcompgas_method,
    answers -> 'wstsourcehprodcompgasquant'->>'response' AS prodcompgas_quant,
    answers -> 'wstsourcehprodcompgasunit'->>'response' AS prodcompgas_unit,

    answers -> 'wstsourcehprodcontammatdisposal'->>'response' AS prodcontammat_method,
    answers -> 'wstsourcehprodcontammatquant'->>'response' AS prodcontammat_quant,
    answers -> 'wstsourcehprodcontammatunit'->>'response' AS prodcontammat_unit,

    answers -> 'wstsourcehdombatteriesdisposal'->>'response' AS dombatteries_method,
    answers -> 'wstsourcehdombatteriesquant'->>'response' AS dombatteries_quant,
    answers -> 'wstsourcehdombatteriesunit'->>'response' AS dombatteries_unit,

    answers -> 'wstsourcehdomflolightdisposal'->>'response' AS domflolight_method,
    answers -> 'wstsourcehdomflolightquant'->>'response' AS domflolight_quant,
    answers -> 'wstsourcehdomflolightunit'->>'response' AS domflolight_unit,

    answers -> 'wstsourcehdominkcartdisposal'->>'response' AS dominkcart_method,
    answers -> 'wstsourcehdominkcartquant'->>'response' AS dominkcart_quant,
    answers -> 'wstsourcehdominkcartunit'->>'response' AS dominkcart_unit,

    answers -> 'wstsourcehdomoilgreasedisposal'->>'response' AS domoilgrease_method,
    answers -> 'wstsourcehdomoilgreasequant'->>'response' AS domoilgrease_quant,
    answers -> 'wstsourcehdomoilgreaseunit'->>'response' AS domoilgrease_unit,

    answers -> 'wstsourcehproductionoildisposal'->>'response' AS productionoil_method,
    answers -> 'wstsourcehproductionoilquant'->>'response' AS productionoil_quant,
    answers -> 'wstsourcehproductionoilunit'->>'response' AS productionoil_unit,

    answers -> 'wstsourcehmetalsludgedisposal'->>'response' AS metalsludge_method,
    answers -> 'wstsourcehmetalsludgequant'->>'response' AS metalsludge_quant,
    answers -> 'wstsourcehmetalsludgeunit'->>'response' AS metalsludge_unit,

    answers -> 'wstsourcehemptyotherdisposal'->>'response' AS h_emptyother_method,
    answers -> 'wstsourcehemptyotherquant'->>'response' AS h_emptyother_quant,
    answers -> 'wstsourcehemptyotherunit'->>'response' AS h_emptyother_unit,

    answers -> 'wstsourcehdomelectronicdisposal'->>'response' AS domelectronic_method,
    answers -> 'wstsourcehdomelectronicquant'->>'response' AS domelectronic_quant,
    answers -> 'wstsourcehdomelectronicunit'->>'response' AS domelectronic_unit,

    answers -> 'wstsourcehdomcoalcombdisposal'->>'response' AS domcoalcomb_method,
    answers -> 'wstsourcehdomcoalcombquant'->>'response' AS domcoalcomb_quant,
    answers -> 'wstsourcehdomcoalcombunit'->>'response' AS domcoalcomb_unit,

    answers -> 'wstsourcehslagdisposal'->>'response' AS slag_h_method,
    answers -> 'wstsourcehslagquant'->>'response' AS slag_h_quant,
    answers -> 'wstsourcehslagunit'->>'response' AS slag_h_unit,

    answers -> 'wstsourcehotherdisposal'->>'response' AS h_other_method,
    answers -> 'wstsourcehotherquant'->>'response' AS h_other_quant,
    answers -> 'wstsourcehotherunit'->>'response' AS h_other_unit
    
FROM isaac_hopwood.fem2023_24_answers_tmp