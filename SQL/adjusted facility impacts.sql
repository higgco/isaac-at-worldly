SELECT
	rfi_pid, 
	COUNT (DISTINCT assessment_id) AS adjusted_count
FROM isaac_hopwood.adjusted_facility_impacts
WHERE (domestic_total_kgco2e + vehicle_total_kgco2e > 0)
GROUP BY 1