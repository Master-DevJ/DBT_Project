-- models/highest_lowest_revenue_by_os_name.sql

-- Calculate week-wise highest and lowest revenue by os_name
WITH revenue_by_os_name_weekly AS (
    SELECT 
        WEEK_NUMBER,
        OS_NAME,
        SUM(REVENUE_USD) AS total_revenue
    FROM combined_data
    GROUP BY WEEK_NUMBER, OS_NAME
),
week_wise_highest_revenue_by_os_name AS (
    SELECT 
        WEEK_NUMBER,
        OS_NAME,
        total_revenue,
        RANK() OVER (PARTITION BY WEEK_NUMBER ORDER BY total_revenue DESC) AS rank_highest
    FROM revenue_by_os_name_weekly
),
week_wise_lowest_revenue_by_os_name AS (
    SELECT 
        WEEK_NUMBER,
        OS_NAME,
        total_revenue,
        RANK() OVER (PARTITION BY WEEK_NUMBER ORDER BY total_revenue) AS rank_lowest
    FROM revenue_by_os_name_weekly
)
SELECT 
    h.WEEK_NUMBER,
    h.OS_NAME AS highest_revenue_os,
    h.total_revenue AS highest_revenue,
    l.OS_NAME AS lowest_revenue_os,
    l.total_revenue AS lowest_revenue
FROM week_wise_highest_revenue_by_os_name h
JOIN week_wise_lowest_revenue_by_os_name l
ON h.WEEK_NUMBER = l.WEEK_NUMBER
WHERE h.rank_highest = 1 AND l.rank_lowest = 1
ORDER BY h.WEEK_NUMBER
