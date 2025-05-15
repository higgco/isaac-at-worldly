-- Pull in FEM responses
WITH t1 AS (
    SELECT 
        assessment_id,
        account_id,
        rfi_pid,
        status,
        answer.key::text AS key,
        answer.value
    FROM 
        public.fem_simple,
        jsonb_each(answers) AS answer
    WHERE 
        rfi_pid = 'fem2023' 
        AND facility_posted 
        AND status <> 'ASD'
),

-- Pull in calculations for waste volumes
t2 AS (
    SELECT 
        assessment_id,
        account_id,
        rfi_pid,
        status,
        answer.key::text AS key,
        answer.value
    FROM 
        public.fem_simple,
        jsonb_each(calculations) AS answer
    WHERE 
        rfi_pid = 'fem2023' 
        AND facility_posted 
        AND status <> 'ASD'
),

-- Pull in facility types
fac_types AS (
    SELECT 
        assessment_id, 
        fac_type::text
    FROM 
        t1,
        jsonb_array_elements(value) AS fac_type
    WHERE 
        t1.key = 'sipfacilitytype'
),

-- Filter for disposal method per waste source
disposal_methods AS (
    SELECT 
        t1.assessment_id, 
        account_id, 
        rfi_pid, 
        CASE 
            WHEN key LIKE '%nh%' THEN 'non-hazardous'
            ELSE 'hazardous' 
        END AS waste_type,
        SUBSTRING(key FROM 1 FOR LENGTH(key) - 8) AS short_name, 
        trim(both '"' from answer::text) AS disposal_method
    FROM 
        t1, 
        jsonb_array_elements(value) AS answer
    WHERE 
        key LIKE 'wst%disposal'
),

-- Pull in quantitative data
waste_volumes AS (
    SELECT 
        assessment_id, 
        key,  
        CASE 
            WHEN key LIKE '%nh%' THEN 'non-hazardous'
            ELSE 'hazardous' 
        END AS waste_type,
        SUBSTRING(key FROM 1 FOR LENGTH(key) - 5) AS short_name,
        value::numeric AS value
    FROM 
        t2
    WHERE 
        key LIKE 'wstsource%total' 
        AND key NOT IN ('wstsourcetotal', 'wstsourcehtotal', 'wstsourcenhtotal')
),

-- Filter volumes greater than zero
waste_volume_clean AS (
    SELECT DISTINCT 
        assessment_id, 
        key, 
        waste_type, 
        short_name, 
        value
    FROM 
        waste_volumes
    WHERE 
        value > 0
),

-- Merge disposal methods and waste volumes
merging_disposal_and_volume AS (
    SELECT DISTINCT 
        disposal_methods.*, 
        waste_volume_clean.value AS waste_vol
    FROM 
        disposal_methods
    FULL JOIN 
        waste_volume_clean
    ON 
        disposal_methods.assessment_id = waste_volume_clean.assessment_id
        AND disposal_methods.short_name = waste_volume_clean.short_name
),

-- Split volume evenly across multiple disposal methods
split AS (
    SELECT 
        merging_disposal_and_volume.*, 
        waste_vol / COUNT(*) OVER (PARTITION BY assessment_id, short_name) AS split_vol,
        COUNT(*) OVER (PARTITION BY assessment_id, short_name) AS split_total
    FROM 
        merging_disposal_and_volume
),

-- Final dataset with optional filtering or ordering
dispers AS (
    SELECT 
        * 
    FROM 
        split
    ORDER BY 
        assessment_id, 
        waste_type, 
        short_name, 
        disposal_method
)

-- Final output
SELECT
	SUM(split_vol) AS vol,
	CASE WHEN split_total > 1 THEN 'Multiple disposal methods'
		ELSE disposal_method
	END AS disposal_method_agg,
	waste_type
FROM dispers
GROUP BY 2,3
ORDER BY 1 DESC;