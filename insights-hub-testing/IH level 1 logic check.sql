with cte AS(
SELECT
    CUBE.assessment_id,
    CUBE.rfi_pid,
    CUBE.status,
    (CUBE.calculations ->> 'levelOneEmsAchieved')::boolean AS calc_ems_level1,
    (CUBE.calculations ->> 'levelOneEnergyAchieved')::boolean AS calc_energy_level1,
    (CUBE.calculations ->> 'levelOneWaterAchieved')::boolean AS calc_water_level1,
    (CUBE.calculations ->> 'levelOneWasteWaterAchieved')::boolean AS calc_ww_level1,
    (CUBE.calculations ->> 'levelOneAirEmissionsAchieved')::boolean AS calc_air_level1,
    (CUBE.calculations ->> 'levelOneWasteAchieved')::boolean AS calc_waste_level1,
    (CUBE.calculations ->> 'levelOneChemicalsAchieved')::boolean AS calc_chem_level1,

    (CUBE.performance ->> 'achieved_ems_level1')::boolean AS perf_ems_level1,
    (CUBE.performance ->> 'achieved_energy_level1')::boolean AS perf_energy_level1,
    (CUBE.performance ->> 'achieved_water_level1')::boolean AS perf_water_level1,
    (CUBE.performance ->> 'achieved_ww_level1')::boolean AS perf_ww_level1,
    (CUBE.performance ->> 'achieved_air_level1')::boolean AS perf_air_level1,
    (CUBE.performance ->> 'achieved_waste_level1')::boolean AS perf_waste_level1,
    (CUBE.performance ->> 'achieved_chem_level1')::boolean AS perf_chem_level1

FROM public.fem_simple AS CUBE
LEFT JOIN public.fem_shares fs ON fs.assessment_id = CUBE.assessment_id
WHERE fs.share_status = 'accepted'
    -- AND fs.account_id = '67cf0312482e3b00be3f7574' -- 12k test account
    AND fs.account_id = '5a4b51e8be5af114f55a0832' -- GAP Inc.
    AND CUBE.rfi_pid IN (
        -- 'fem2022', 
        'fem2023', 'fem2024') 
    -- AND CUBE.verifier_posted = FALSE
),

cte2 AS(
SELECT
    assessment_id,
    rfi_pid,
    CASE WHEN calc_ems_level1 = perf_ems_level1 THEN 'Pass' ELSE 'Fail' END as ems_level1_pass,
    CASE WHEN calc_energy_level1 = perf_energy_level1 THEN 'Pass' ELSE 'Fail' END as energy_level1_pass,
    CASE WHEN calc_water_level1 = perf_water_level1 THEN 'Pass' ELSE 'Fail' END as water_level1_pass,
    CASE WHEN calc_ww_level1 = perf_ww_level1 THEN 'Pass' ELSE 'Fail' END as ww_level1_pass,
    CASE WHEN calc_air_level1 = perf_air_level1 THEN 'Pass' ELSE 'Fail' END as air_level1_pass,
    CASE WHEN calc_waste_level1 = perf_waste_level1 THEN 'Pass' ELSE 'Fail' END as waste_level1_pass,
    CASE WHEN calc_chem_level1 = perf_chem_level1 THEN 'Pass' ELSE 'Fail' END as chem_level1_pass
FROM cte
)

-- SELECT
--     COUNT(*) as total_assessments,
--     rfi_pid,
--     SUM(CASE WHEN ems_level1_pass = 'Fail' THEN 1 ELSE 0 END) as ems_level1_fail,
--     SUM(CASE WHEN energy_level1_pass = 'Fail' THEN 1 ELSE 0 END) as energy_level1_fail,
--     SUM(CASE WHEN water_level1_pass = 'Fail' THEN 1 ELSE 0 END) as water_level1_fail,
--     SUM(CASE WHEN ww_level1_pass = 'Fail' THEN 1 ELSE 0 END) as ww_level1_fail,
--     SUM(CASE WHEN air_level1_pass = 'Fail' THEN 1 ELSE 0 END) as air_level1_fail,
--     SUM(CASE WHEN waste_level1_pass = 'Fail' THEN 1 ELSE 0 END) as waste_level1_fail,
--     SUM(CASE WHEN chem_level1_pass = 'Fail' THEN 1 ELSE 0 END) as chem_level1_fail
-- FROM cte2
-- GROUP BY 2

SELECT 
    cte2.assessment_id,
    cte.status,
    cte2.rfi_pid,
    cte.calc_ems_level1,
    cte.perf_ems_level1,
    cte.calc_energy_level1,
    cte.perf_energy_level1,
    cte.calc_water_level1,
    cte.perf_water_level1,
    cte.calc_ww_level1,
    cte.perf_ww_level1,
    cte.calc_air_level1,
    cte.perf_air_level1,
    cte.calc_waste_level1,
    cte.perf_waste_level1,
    cte.calc_chem_level1,
    cte.perf_chem_level1
FROM cte2
INNER JOIN cte ON cte.assessment_id = cte2.assessment_id
WHERE (
    cte2.ems_level1_pass = 'Fail'
    OR cte2.energy_level1_pass = 'Fail'
    OR cte2.water_level1_pass = 'Fail'
    OR cte2.ww_level1_pass = 'Fail'
    OR cte2.air_level1_pass = 'Fail'
    OR cte2.waste_level1_pass = 'Fail'
    OR cte2.chem_level1_pass = 'Fail'
)