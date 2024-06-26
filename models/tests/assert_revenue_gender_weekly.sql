-- tests/assert_revenue_gender_weekly.sql

WITH actual AS (
    SELECT 
        WEEK_NUMBER,
        GENDER,
        total_revenue_weekly
    FROM {{ ref('test_revenue_gender_weekly') }}
),

expected AS (
    SELECT 
        WEEK_NUMBER,
        GENDER,
        total_revenue_weekly
    FROM {{ ref('expected_revenue_gender_weekly') }}
)

SELECT 
    actual.WEEK_NUMBER,
    actual.GENDER,
    actual.total_revenue_weekly,
    expected.total_revenue_weekly
FROM actual
LEFT JOIN expected
ON actual.WEEK_NUMBER = expected.WEEK_NUMBER
AND actual.GENDER = expected.GENDER

WHERE actual.total_revenue_weekly != expected.total_revenue_weekly
