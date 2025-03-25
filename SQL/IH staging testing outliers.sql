SELECT
	a.name AS shared_with,
	fem.account_id AS supplier_id,
	fem.assessment_id,
	fem.performance -> 'ensourcetotal' AS total_mj
FROM public.fem_shares AS s
INNER JOIN public.fem_simple AS fem
	ON (fem.assessment_id = s.assessment_id)
INNER JOIN public.account AS a
	ON (a.account_id = s.account_id)
WHERE
	(fem.performance -> 'ensourcetotal')::NUMERIC > 1035500000
	a.account_id IN (
	'67cc6b318498810134a7b2d0', --FEM 99 Small v030825
	'67cc694ee7fc5d012979b13e', --FEM 170 Small v030825
	'67cbd154250c3f00fdebbaa4', --FEM 900 Medium v030825
	'67cc6c28ab428a013f5fa7d3', --FEM 1250 Medium v030825
	'67cf0312482e3b00be3f7574' --FEM 12k Large v031025
	)