SELECT 
    GENDER,
    SUM(REVENUE_USD) AS total_revenue_overall
FROM combined_data
GROUP BY GENDER