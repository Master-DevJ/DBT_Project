-- tests/assert_devices_weekly.sql

WITH actual AS (
    SELECT 
        WEEK_NUMBER,
        total_devices_weekly,
        active_devices_weekly
    FROM {{ ref('test_devices_weekly') }}
),

expected AS (
    SELECT 
        WEEK_NUMBER,
        total_devices_weekly,
        active_devices_weekly
    FROM {{ ref('expected_devices_weekly') }}
)

SELECT 
    actual.WEEK_NUMBER,
    actual.total_devices_weekly,
    actual.active_devices_weekly,
    expected.total_devices_weekly,
    expected.active_devices_weekly
FROM actual
LEFT JOIN expected
ON actual.WEEK_NUMBER = expected.WEEK_NUMBER

WHERE actual.total_devices_weekly != expected.total_devices_weekly
OR actual.active_devices_weekly != expected.active_devices_weekly
