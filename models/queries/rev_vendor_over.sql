-- models/revenue_by_os_vendor.sql

-- Calculate total revenue distribution by os_vendor overall and week-wise
SELECT 
    OS_VENDOR,
    SUM(REVENUE_USD) AS total_revenue_overall
FROM combined_data
GROUP BY OS_VENDOR