DROP TABLE IF EXISTS isaac_hopwood.fem2023_24_answers_final;

CREATE TABLE isaac_hopwood.fem2023_24_answers_final AS
SELECT
    assessment_id,
	rfi_pid,
    
    answers -> 'wstsourcenhtextiledisposal' AS textile_method,
    CAST(performance -> 'wstsourcenhtextilequant' AS NUMERIC) AS textile_quant_kg,
    
    answers -> 'wstsourcenhleatherdisposal' AS leather_method,
    CAST(performance -> 'wstsourcenhleatherquant' AS NUMERIC) AS leather_quant_kg,

    answers -> 'wstsourcenhrubberdisposal' AS rubber_method,
    CAST(performance -> 'wstsourcenhrubberquant' AS NUMERIC) AS rubber_quant_kg,

    answers -> 'wstsourcenhmetaldisposal' AS metal_method,
    CAST(performance -> 'wstsourcenhmetalquant' AS NUMERIC) AS metal_quant_kg,

    answers -> 'wstsourcenhplasticdisposal' AS plastic_method,
    CAST(performance -> 'wstsourcenhplasticquant' AS NUMERIC) AS plastic_quant_kg,

    answers -> 'wstsourcenhpaperdisposal' AS paper_method,
    CAST(performance -> 'wstsourcenhpaperquant' AS NUMERIC) AS paper_quant_kg,

    answers -> 'wstsourcenhcansdisposal' AS cans_method,
    CAST(performance -> 'wstsourcenhcansquant' AS NUMERIC) AS cans_quant_kg,

    answers -> 'wstsourcenhwooddisposal' AS wood_method,
    CAST(performance -> 'wstsourcenhwoodquant' AS NUMERIC) AS wood_quant_kg,
    
    answers -> 'wstsourcenhfooddisposal' AS food_method,
    CAST(performance -> 'wstsourcenhfoodquant' AS NUMERIC) AS food_quant_kg,

    answers -> 'wstsourcenhglassdisposal' AS glass_method,
    CAST(performance -> 'wstsourcenhglassquant' AS NUMERIC) AS glass_quant_kg,

    answers -> 'wstsourcenhcartonsdisposal' AS cartons_method,
    CAST(performance -> 'wstsourcenhcartonsquant' AS NUMERIC) AS cartons_quant_kg,

    answers -> 'wstsourcenhfoamsdisposal' AS foams_method,
    CAST(performance -> 'wstsourcenhfoamsquant' AS NUMERIC) AS foams_quant_kg,

    answers -> 'wstsourcenhwastewaterTreatmentSludgedisposal' AS wastewaterTreatmentSludge_method,
    CAST(performance -> 'wstsourcenhwastewaterTreatmentSludgequant' AS NUMERIC) AS wastewaterTreatmentSludge_quant_kg,

    answers -> 'wstsourcenhgeneraldisposal' AS nh_general_method,
    CAST(performance -> 'wstsourcenhgeneralquant' AS NUMERIC) AS nh_general_quant_kg,

    answers -> 'wstsourcenhslagnhdisposal' AS slag_nh_method,
    CAST(performance -> 'wstsourcenhslagnhquant' AS NUMERIC) AS slag_nh_quant_kg,

    answers -> 'wstsourcenhotherdisposal' AS nh_other_method,
    CAST(performance -> 'wstsourcenhotherquant' AS NUMERIC) AS nh_other_quant_kg,

    answers -> 'wstsourcehprodchemdrumdisposal' AS prodchemdrum_method,
    CAST(performance -> 'wstsourcehprodchemdrumquant' AS NUMERIC) AS prodchemdrum_quant_kg,

    answers -> 'wstsourcehprodfilmprintdisposal' AS prodfilmprint_method,
    CAST(performance -> 'wstsourcehprodfilmprintquant' AS NUMERIC) AS prodfilmprint_quant_kg,

    answers -> 'wstsourcehprodsludgedisposal' AS prodsludge_method,
    CAST(performance -> 'wstsourcehprodsludgequant' AS NUMERIC) AS prodsludge_quant_kg,

    answers -> 'wstsourcehprodchemdisposal' AS prodchem_method,
    CAST(performance -> 'wstsourcehprodchemquant' AS NUMERIC) AS prodchem_quant_kg,

    answers -> 'wstsourcehprodcompgasdisposal' AS prodcompgas_method,
    CAST(performance -> 'wstsourcehprodcompgasquant' AS NUMERIC) AS prodcompgas_quant_kg,

    answers -> 'wstsourcehprodcontammatdisposal' AS prodcontammat_method,
    CAST(performance -> 'wstsourcehprodcontammatquant' AS NUMERIC) AS prodcontammat_quant_kg,

    answers -> 'wstsourcehdombatteriesdisposal' AS dombatteries_method,
    CAST(performance -> 'wstsourcehdombatteriesquant' AS NUMERIC) AS dombatteries_quant_kg,

    answers -> 'wstsourcehdomflolightdisposal' AS domflolight_method,
    CAST(performance -> 'wstsourcehdomflolightquant' AS NUMERIC) AS domflolight_quant_kg,

    answers -> 'wstsourcehdominkcartdisposal' AS dominkcart_method,
    CAST(performance -> 'wstsourcehdominkcartquant' AS NUMERIC) AS dominkcart_quant_kg,

    answers -> 'wstsourcehdomoilgreasedisposal' AS domoilgrease_method,
    CAST(performance -> 'wstsourcehdomoilgreasequant' AS NUMERIC) AS domoilgrease_quant_kg,

    answers -> 'wstsourcehproductionoildisposal' AS productionoil_method,
    CAST(performance -> 'wstsourcehproductionoilquant' AS NUMERIC) AS productionoil_quant_kg,

    answers -> 'wstsourcehmetalsludgedisposal' AS metalsludge_method,
    CAST(performance -> 'wstsourcehmetalsludgequant' AS NUMERIC) AS metalsludge_quant_kg,

    answers -> 'wstsourcehemptyotherdisposal' AS h_emptyother_method,
    CAST(performance -> 'wstsourcehemptyotherquant' AS NUMERIC) AS h_emptyother_quant_kg,

    answers -> 'wstsourcehdomelectronicdisposal' AS domelectronic_method,
    CAST(performance -> 'wstsourcehdomelectronicquant' AS NUMERIC) AS domelectronic_quant_kg,

    answers -> 'wstsourcehdomcoalcombdisposal' AS domcoalcomb_method,
    CAST(performance -> 'wstsourcehdomcoalcombquant' AS NUMERIC) AS domcoalcomb_quant_kg,

    answers -> 'wstsourcehslagdisposal' AS slag_h_method,
    CAST(performance -> 'wstsourcehslagquant' AS NUMERIC) AS slag_h_quant_kg,

    answers -> 'wstsourcehotherdisposal' AS h_other_method,
    CAST(performance -> 'wstsourcehotherquant' AS NUMERIC) AS h_other_quant_kg
    
FROM isaac_hopwood.fem2023_24_answers_tmp;