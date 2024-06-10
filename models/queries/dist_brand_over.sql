-- models/customer_distribution_by_brand_name.sql

-- Calculate total distribution of customers by brand_name overall and week-wise
SELECT 
    BRAND_NAME,
    COUNT(DISTINCT MSISDN) AS total_customers_overall
FROM combined_data
GROUP BY BRAND_NAME
