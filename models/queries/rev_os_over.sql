-- models/revenue_by_os_name.sql

SELECT 
    OS_NAME,
    SUM(REVENUE_USD) AS total_revenue_overall
FROM combined_data
GROUP BY OS_NAME