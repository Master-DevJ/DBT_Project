SELECT 
    COUNT(DISTINCT IMEI_TAC) AS total_devices_overall,
    COUNT(DISTINCT CASE WHEN SYSTEM_STATUS = 'ACTIVE' THEN IMEI_TAC END) AS active_devices_overall
FROM combined_data

