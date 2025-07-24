WITH cte AS (
  SELECT
      msi.msi_id,
      msi.account_id,
      bm ->> '_id' AS base_material_id,
      (
          coalesce(bm -> 'cycles' -> 'P001' -> 'processes', '[]'::jsonb) ||
          coalesce(bm -> 'cycles' -> 'P002' -> 'processes', '[]'::jsonb) ||
          coalesce(bm -> 'cycles' -> 'P003' -> 'processes', '[]'::jsonb) ||
          coalesce(bm -> 'cycles' -> 'P004' -> 'processes', '[]'::jsonb) ||
          coalesce(bm -> 'cycles' -> 'P005' -> 'processes', '[]'::jsonb)
      )::text AS all_processes
  FROM public.msi msi
  JOIN public.account a ON a.account_id = msi.account_id
  CROSS JOIN LATERAL jsonb_array_elements(msi.raw -> 'version' -> 'baseMaterials') AS bm
  WHERE a.demo = FALSE AND a.active = TRUE
)

-- Count of MSI IDs and Account IDs
-- SELECT
--     COUNT(DISTINCT msi_id) AS count_id,
--     COUNT(DISTINCT account_id) AS count_account_id
-- FROM cte
-- WHERE all_processes ILIKE '%PR0804000852%';

-- Accounts with MSI IDs that include the specified process
SELECT
    DISTINCT cte.account_id AS account_id,
    a.name AS account_name,
    COUNT(DISTINCT msi_id) AS count_id
FROM cte
LEFT JOIN public.account a ON a.account_id = cte.account_id
WHERE all_processes ILIKE '%PR0804000852%'
GROUP BY cte.account_id, a.name;


-- Count MSI IDs per account first, then count how many accounts fall into each count
-- SELECT 
--     msi_per_account.count_msi_ids,
--     COUNT(*) AS num_accounts
-- FROM (
--     SELECT 
--         account_id,
--         COUNT(DISTINCT msi_id) AS count_msi_ids
--     FROM cte
--     WHERE all_processes ILIKE '%PR0804000852%'
--     GROUP BY account_id
-- ) AS msi_per_account
-- GROUP BY msi_per_account.count_msi_ids
-- ORDER BY msi_per_account.count_msi_ids;