SELECT 
    WEEK_NUMBER,
    OS_VENDOR,
    SUM(REVENUE_USD) AS total_revenue_weekly
FROM combined_data
GROUP BY WEEK_NUMBER, OS_VENDOR