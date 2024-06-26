-- models/tests/test_revenue_gender_weekly.sql

WITH combined_data AS (
    SELECT 
        1 AS WEEK_NUMBER, 'M' AS GENDER, 100 AS REVENUE_USD
    UNION ALL
        SELECT 1, 'F', 200
    UNION ALL
        SELECT 2, 'M', 150
    UNION ALL
        SELECT 2, 'F', 250
)

SELECT 
    WEEK_NUMBER,
    GENDER,
    SUM(REVENUE_USD) AS total_revenue_weekly
FROM combined_data
GROUP BY WEEK_NUMBER, GENDER
