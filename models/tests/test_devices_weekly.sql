-- models/tests/test_devices_weekly.sql

WITH combined_data AS (
    SELECT 
        1 AS WEEK_NUMBER, 'DEVICE1' AS IMEI_TAC, 'ACTIVE' AS SYSTEM_STATUS
    UNION ALL
        SELECT 1, 'DEVICE2', 'INACTIVE'
    UNION ALL
        SELECT 2, 'DEVICE1', 'ACTIVE'
    UNION ALL
        SELECT 2, 'DEVICE3', 'ACTIVE'
    UNION ALL
        SELECT 2, 'DEVICE4', 'INACTIVE'
)

SELECT 
    WEEK_NUMBER,
    COUNT(DISTINCT IMEI_TAC) AS total_devices_weekly,
    COUNT(DISTINCT CASE WHEN SYSTEM_STATUS = 'ACTIVE' THEN IMEI_TAC END) AS active_devices_weekly
FROM combined_data
GROUP BY WEEK_NUMBER
