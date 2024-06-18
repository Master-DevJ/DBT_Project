-- models/customer_distribution_by_mobile_type.sql

-- Calculate total distribution of customers by mobile_type overall and week-wise
SELECT 
    MOBILE_TYPE,
    COUNT(DISTINCT MSISDN) AS total_customers_overall
FROM combined_data
GROUP BY MOBILE_TYPE