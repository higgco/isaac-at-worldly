WITH cte AS (
  SELECT
    assessment_id,
    answers ->> 'ensourcecng' AS cng,
    answers ->> 'ensourcecoalwaterslurry' AS coalwaterslurry,
    answers ->> 'ensourcediesel' AS diesel,
    answers ->> 'ensourcefueloil' AS fueloil,
    answers ->> 'ensourcelng' AS lng,
    answers ->> 'ensourcelpg' AS lpg,
    answers ->> 'ensourcenaturalgas' AS naturalgas,
    answers ->> 'ensourcepetrol' AS petrol,
    answers ->> 'ensourcepropane' AS propane
  FROM public.fem_simple
  WHERE rfi_pid = 'fem2023'
)

SELECT
  cte.assessment_id,
  array_to_string(array_remove(ARRAY[
    CASE WHEN cng = 'Yes' THEN 'CNG - Compressed Natural Gas' ELSE NULL END,
    CASE WHEN coalwaterslurry = 'Yes' THEN 'Coal Water Slurry' ELSE NULL END,
    CASE WHEN diesel = 'Yes' THEN 'Diesel' ELSE NULL END,
    CASE WHEN fueloil = 'Yes' THEN 'Fuel Oil - Blended' ELSE NULL END,
    CASE WHEN lng = 'Yes' THEN 'LNG - Liquid Natural Gas' ELSE NULL END,
    CASE WHEN lpg = 'Yes' THEN 'LPG - Liquid Petroleum Gas' ELSE NULL END,
    CASE WHEN naturalgas = 'Yes' THEN 'Natural Gas' ELSE NULL END,
    CASE WHEN petrol = 'Yes' THEN 'Petrol/Gasoline' ELSE NULL END,
    CASE WHEN propane = 'Yes' THEN 'Propane' ELSE NULL END
  ], NULL), ', ') AS ensourcefacility
FROM cte;