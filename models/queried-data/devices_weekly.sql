-- models/combined_data_analysis.sql

-- Calculate device counts overall and week-wise

SELECT 
    WEEK_NUMBER,
    COUNT(DISTINCT IMEI_TAC) AS total_devices_weekly,
    COUNT(DISTINCT CASE WHEN SYSTEM_STATUS = 'ACTIVE' THEN IMEI_TAC END) AS active_devices_weekly
FROM combined_data
GROUP BY WEEK_NUMBER
