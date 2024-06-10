SELECT 
    COUNT(DISTINCT MSISDN) AS total_customers_overall,
    COUNT(DISTINCT CASE WHEN SYSTEM_STATUS = 'ACTIVE' THEN MSISDN END) AS active_customers_overall
FROM combined_data