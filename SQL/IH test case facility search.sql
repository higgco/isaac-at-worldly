SELECT
	DISTINCT fem.assessment_id,
	a.name,
	fem.account_id,
	fem.rfi_pid,
	fem.status,
	fem.performance ->> 'sipfacilitytype' AS facility_type
FROM public.fem_simple AS fem
LEFT JOIN public.account AS a
USING (account_id)
WHERE
	fem.facility_posted = true
	AND fem.status = 'ASC'
	-- AND (
	-- 	fem.answers ->> 'sipfacilitytype' = '["Finished Product Assembler", "Finished Product Processing (Product Printing, Product Painting, Product Dyeing, Product Laundering and Product Finishing, Embroidery & Embellishments)"]'
	-- 	OR fem.answers ->> 'sipfacilitytype' = '["Finished Product Processing (Product Printing, Product Painting, Product Dyeing, Product Laundering and Product Finishing, Embroidery & Embellishments)","Finished Product Assembler"]'
	-- 	)
ORDER BY 3,4