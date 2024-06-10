-- models/revenue_by_mobile_type.sql

-- Calculate total revenue distribution by mobile type overall and week-wise

SELECT 
    MOBILE_TYPE,
    SUM(REVENUE_USD) AS total_revenue_overall
FROM combined_data
GROUP BY MOBILE_TYPE