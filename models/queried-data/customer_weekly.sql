-- models/customer_counts.sql

-- Calculate customer counts overall and week-wise

SELECT 
    WEEK_NUMBER,
    COUNT(DISTINCT MSISDN) AS total_customers_weekly,
    COUNT(DISTINCT CASE WHEN SYSTEM_STATUS = 'ACTIVE' THEN MSISDN END) AS active_customers_weekly
FROM combined_data
GROUP BY WEEK_NUMBER