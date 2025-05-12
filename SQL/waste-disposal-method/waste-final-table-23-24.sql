DROP TABLE IF EXISTS isaac_hopwood.fem2023_24_answers_final;

CREATE TABLE isaac_hopwood.fem2023_24_answers_final AS
SELECT
    assessment_id,
	rfi_pid,
    
    answers -> 'wstsourcenhtextiledisposal' AS textile_method,
    CAST(performance -> 'wstsourcenhtextiletotal' AS NUMERIC) AS textile_quant_kg,
    
    answers -> 'wstsourcenhleatherdisposal' AS leather_method,
    CAST(performance -> 'wstsourcenhleathertotal' AS NUMERIC) AS leather_quant_kg,

    answers -> 'wstsourcenhrubberdisposal' AS rubber_method,
    CAST(performance -> 'wstsourcenhrubbertotal' AS NUMERIC) AS rubber_quant_kg,

    answers -> 'wstsourcenhmetaldisposal' AS metal_method,
    CAST(performance -> 'wstsourcenhmetaltotal' AS NUMERIC) AS metal_quant_kg,

    answers -> 'wstsourcenhplasticdisposal' AS plastic_method,
    CAST(performance -> 'wstsourcenhplastictotal' AS NUMERIC) AS plastic_quant_kg,

    answers -> 'wstsourcenhpaperdisposal' AS paper_method,
    CAST(performance -> 'wstsourcenhpapertotal' AS NUMERIC) AS paper_quant_kg,

    answers -> 'wstsourcenhcansdisposal' AS cans_method,
    CAST(performance -> 'wstsourcenhcanstotal' AS NUMERIC) AS cans_quant_kg,

    answers -> 'wstsourcenhwooddisposal' AS wood_method,
    CAST(performance -> 'wstsourcenhwoodtotal' AS NUMERIC) AS wood_quant_kg,
    
    answers -> 'wstsourcenhfooddisposal' AS food_method,
    CAST(performance -> 'wstsourcenhfoodtotal' AS NUMERIC) AS food_quant_kg,

    answers -> 'wstsourcenhglassdisposal' AS glass_method,
    CAST(performance -> 'wstsourcenhglasstotal' AS NUMERIC) AS glass_quant_kg,

    answers -> 'wstsourcenhcartonsdisposal' AS cartons_method,
    CAST(performance -> 'wstsourcenhcartonstotal' AS NUMERIC) AS cartons_quant_kg,

    answers -> 'wstsourcenhfoamsdisposal' AS foams_method,
    CAST(performance -> 'wstsourcenhfoamstotal' AS NUMERIC) AS foams_quant_kg,

    answers -> 'wstsourcenhwastewaterTreatmentSludgedisposal' AS wastewaterTreatmentSludge_method,
    CAST(performance -> 'wstsourcenhwastewaterTreatmentSludgetotal' AS NUMERIC) AS wastewaterTreatmentSludge_quant_kg,

    answers -> 'wstsourcenhgeneraldisposal' AS nh_general_method,
    CAST(performance -> 'wstsourcenhgeneraltotal' AS NUMERIC) AS nh_general_quant_kg,

    answers -> 'wstsourcenhslagnhdisposal' AS slag_nh_method,
    CAST(performance -> 'wstsourcenhslagnhtotal' AS NUMERIC) AS slag_nh_quant_kg,

    answers -> 'wstsourcenhotherdisposal' AS nh_other_method,
    CAST(performance -> 'wstsourcenhothertotal' AS NUMERIC) AS nh_other_quant_kg,

    answers -> 'wstsourcehprodchemdrumdisposal' AS prodchemdrum_method,
    CAST(performance -> 'wstsourcehprodchemdrumtotal' AS NUMERIC) AS prodchemdrum_quant_kg,

    answers -> 'wstsourcehprodfilmprintdisposal' AS prodfilmprint_method,
    CAST(performance -> 'wstsourcehprodfilmprinttotal' AS NUMERIC) AS prodfilmprint_quant_kg,

    answers -> 'wstsourcehprodsludgedisposal' AS prodsludge_method,
    CAST(performance -> 'wstsourcehprodsludgetotal' AS NUMERIC) AS prodsludge_quant_kg,

    answers -> 'wstsourcehprodchemdisposal' AS prodchem_method,
    CAST(performance -> 'wstsourcehprodchemtotal' AS NUMERIC) AS prodchem_quant_kg,

    answers -> 'wstsourcehprodcompgasdisposal' AS prodcompgas_method,
    CAST(performance -> 'wstsourcehprodcompgastotal' AS NUMERIC) AS prodcompgas_quant_kg,

    answers -> 'wstsourcehprodcontammatdisposal' AS prodcontammat_method,
    CAST(performance -> 'wstsourcehprodcontammattotal' AS NUMERIC) AS prodcontammat_quant_kg,

    answers -> 'wstsourcehdombatteriesdisposal' AS dombatteries_method,
    CAST(performance -> 'wstsourcehdombatteriestotal' AS NUMERIC) AS dombatteries_quant_kg,

    answers -> 'wstsourcehdomflolightdisposal' AS domflolight_method,
    CAST(performance -> 'wstsourcehdomflolighttotal' AS NUMERIC) AS domflolight_quant_kg,

    answers -> 'wstsourcehdominkcartdisposal' AS dominkcart_method,
    CAST(performance -> 'wstsourcehdominkcarttotal' AS NUMERIC) AS dominkcart_quant_kg,

    answers -> 'wstsourcehdomoilgreasedisposal' AS domoilgrease_method,
    CAST(performance -> 'wstsourcehdomoilgreasetotal' AS NUMERIC) AS domoilgrease_quant_kg,

    answers -> 'wstsourcehproductionoildisposal' AS productionoil_method,
    CAST(performance -> 'wstsourcehproductionoiltotal' AS NUMERIC) AS productionoil_quant_kg,

    answers -> 'wstsourcehmetalsludgedisposal' AS metalsludge_method,
    CAST(performance -> 'wstsourcehmetalsludgetotal' AS NUMERIC) AS metalsludge_quant_kg,

    answers -> 'wstsourcehemptyotherdisposal' AS h_emptyother_method,
    CAST(performance -> 'wstsourcehemptyothertotal' AS NUMERIC) AS h_emptyother_quant_kg,

    answers -> 'wstsourcehdomelectronicdisposal' AS domelectronic_method,
    CAST(performance -> 'wstsourcehdomelectronictotal' AS NUMERIC) AS domelectronic_quant_kg,

    answers -> 'wstsourcehdomcoalcombdisposal' AS domcoalcomb_method,
    CAST(performance -> 'wstsourcehdomcoalcombtotal' AS NUMERIC) AS domcoalcomb_quant_kg,

    answers -> 'wstsourcehslagdisposal' AS slag_h_method,
    CAST(performance -> 'wstsourcehslagtotal' AS NUMERIC) AS slag_h_quant_kg,

    answers -> 'wstsourcehotherdisposal' AS h_other_method,
    CAST(performance -> 'wstsourcehothertotal' AS NUMERIC) AS h_other_quant_kg
    
FROM isaac_hopwood.fem2023_24_answers_tmp;