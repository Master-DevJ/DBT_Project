-- models/clean_crm.sql

WITH base_data AS (
    SELECT
        *,
        LOWER(TRIM(gender)) AS cleaned_gender
    FROM {{ ref('crm') }}
),

-- Step 1: Define a CTE for gender cleaning using CASE and Levenshtein distance
gender_cleaned AS (
    SELECT
        *,
        CASE
            WHEN gender IS NULL THEN 'other'
            WHEN LEAST(
                LEVENSHTEIN(LOWER(TRIM(gender)), 'male'),
                LEVENSHTEIN(LOWER(TRIM(gender)), 'm')
            ) <= 2 THEN 'male'
            WHEN LEAST(
                LEVENSHTEIN(LOWER(TRIM(gender)), 'female'),
                LEVENSHTEIN(LOWER(TRIM(gender)), 'f')
            ) <= 2 THEN 'female'
            ELSE 'other'
        END AS cleaned_gender
    FROM base_data
),

-- Step 2: Count null values in each row
null_counted AS (
    SELECT
        *,
        (
            CASE WHEN col1 IS NULL THEN 1 ELSE 0 END +
            CASE WHEN col2 IS NULL THEN 1 ELSE 0 END +
            CASE WHEN col3 IS NULL THEN 1 ELSE 0 END +
            ... -- Add cases for all columns
        ) AS null_count
    FROM gender_cleaned
),

-- Step 3: Rank rows for each msisdn
ranked_data AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY msisdn
            ORDER BY null_count ASC, system_status DESC, cleaned_gender DESC
        ) AS rank
    FROM null_counted
)

-- Step 4: Filter to keep only the top-ranked rows
SELECT
    * EXCEPT (null_count, rank)
FROM ranked_data
WHERE rank = 1
