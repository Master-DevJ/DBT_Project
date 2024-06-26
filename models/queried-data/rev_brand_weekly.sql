-- models/revenue_by_brand_name.sql

-- Calculate total revenue distribution by brand name overall and week-wise
SELECT 
    WEEK_NUMBER,
    BRAND_NAME,
    SUM(REVENUE_USD) AS total_revenue_weekly
FROM combined_data
GROUP BY WEEK_NUMBER, BRAND_NAME