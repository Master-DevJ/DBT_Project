-- models/revenue_by_gender.sql

-- Calculate total revenue by gender overall and week-wise
SELECT 
    WEEK_NUMBER,
    GENDER,
    SUM(REVENUE_USD) AS total_revenue_weekly
FROM combined_data
GROUP BY WEEK_NUMBER, GENDER