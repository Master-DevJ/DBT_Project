-- models/customer_distribution_by_os_name.sql

-- Calculate total distribution of customers by os_name overall and week-wise
SELECT 
    OS_NAME,
    COUNT(DISTINCT MSISDN) AS total_customers_overall
FROM combined_data
GROUP BY OS_NAME