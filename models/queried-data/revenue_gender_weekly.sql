-- models/revenue_gender_weekly.sql

-- Calculate total revenue by gender week-wise
SELECT 
    WEEK_NUMBER,
    GENDER,
    SUM(REVENUE_USD) AS total_revenue_weekly
FROM combined_data
GROUP BY WEEK_NUMBER, GENDER