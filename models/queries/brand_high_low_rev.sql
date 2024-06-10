-- models/highest_lowest_revenue_by_brand_name.sql

WITH weekly_revenue_by_brand AS (
    SELECT 
        WEEK_NUMBER,
        BRAND_NAME,
        SUM(REVENUE_USD) AS total_revenue
    FROM combined_data
    GROUP BY WEEK_NUMBER, BRAND_NAME
),
week_wise_ranked_revenue AS (
    SELECT 
        WEEK_NUMBER,
        BRAND_NAME,
        total_revenue,
        ROW_NUMBER() OVER(PARTITION BY WEEK_NUMBER ORDER BY total_revenue DESC) AS highest_rank,
        ROW_NUMBER() OVER(PARTITION BY WEEK_NUMBER ORDER BY total_revenue ASC) AS lowest_rank
    FROM weekly_revenue_by_brand
)
SELECT
    hr.WEEK_NUMBER,
    hr.BRAND_NAME AS highest_revenue_brand,
    hr.total_revenue AS highest_revenue,
    lr.BRAND_NAME AS lowest_revenue_brand,
    lr.total_revenue AS lowest_revenue
FROM
    week_wise_ranked_revenue hr
JOIN
    week_wise_ranked_revenue lr
ON
    hr.WEEK_NUMBER = lr.WEEK_NUMBER
WHERE
    hr.highest_rank = 1
    AND lr.lowest_rank = 1
ORDER BY
    hr.WEEK_NUMBER
