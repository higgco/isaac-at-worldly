with EF AS(
	SELECT
	assessment_id,
	rfi_pid,
	status,
	answers ->> 'enchilldwateref' AS enchilldwateref,
	answers ->> 'ensourcedistrictheatingefknown' AS ensourcedistrictheatingefknown,
	answers ->> 'ensourcepurchrenewefknown' AS ensourcepurchrenewefknown,
	answers ->> 'enghgefelecpurch' AS enghgefelecpurch
	FROM public.fem_simple
	WHERE facility_posted = true AND (rfi_pid = 'fem2023')
)

SELECT COUNT(assessment_id) FROM EF 
WHERE 
	-- (	
	ensourcepurchrenewefknown LIKE 'Yes'
	-- OR enchilldwateref LIKE 'Yes'
	-- OR ensourcedistrictheatingefknown LIKE 'Yes'
	-- OR enghgefelecpurch LIKE 'Yes')