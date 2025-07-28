WITH msi_flattened_data AS (
	SELECT
		msi_id,
        account_id,
		obj->>'_id' AS tx_id,
		cycle.key AS cycle_key,
		selected_elem->>'id' AS selected_id,
		cycle.value->'processes' AS processes_value,
		raw
	FROM public.msi,
		 jsonb_array_elements((raw->'version'->'baseMaterials')::JSONB) AS obj,
		 jsonb_each(obj->'cycles') AS cycle(key, value),
		 jsonb_array_elements(cycle.value->'selected') AS selected_elem
	WHERE raw->'version'->'baseMaterials' IS NOT NULL
)

-- Count of MSI IDs and Account IDs
SELECT
    COUNT(DISTINCT msi_id) AS count_id,
    COUNT(DISTINCT account_id) AS count_account_id
FROM msi_flattened_data
WHERE selected_id = 'PR0804000852'
;

---
-- Accounts with MSI IDs that include the specified process
-- SELECT
--     msi_id AS msi_id,
--     cte.account_id AS account_id,
--     a.name AS account_name,
--     all_selected_ids
-- FROM cte
-- LEFT JOIN public.account a ON a.account_id = cte.account_id
-- WHERE EXISTS (
--     SELECT 1 FROM unnest(all_selected_ids) AS id
--     WHERE id ILIKE '%PR0804000852%'
-- );

---
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