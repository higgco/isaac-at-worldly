select
	DISTINCT dc.assessment_data_check_id,
	dca.assessment_id,
	dc.is_resolved,
	dc.resolved_type
from public.assessment_data_check AS dc
INNER JOIN public.assessment_data_check_actions AS dca
USING (assessment_data_check_id)
WHERE
	is_resolved = 'false'
	OR resolved_type = 'MANUALRESOLUTION'
order by 2