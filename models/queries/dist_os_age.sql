WITH cleaned_data AS (
    SELECT 
        MSISDN,
        OS_NAME,
        YEAR_OF_BIRTH,
        CASE
            WHEN YEAR_OF_BIRTH BETWEEN 1900 AND 1909 THEN '1900-1909'
            WHEN YEAR_OF_BIRTH BETWEEN 1910 AND 1919 THEN '1910-1919'
            WHEN YEAR_OF_BIRTH BETWEEN 1920 AND 1929 THEN '1920-1929'
            WHEN YEAR_OF_BIRTH BETWEEN 1930 AND 1939 THEN '1930-1939'
            WHEN YEAR_OF_BIRTH BETWEEN 1940 AND 1949 THEN '1940-1949'
            WHEN YEAR_OF_BIRTH BETWEEN 1950 AND 1959 THEN '1950-1959'
            WHEN YEAR_OF_BIRTH BETWEEN 1960 AND 1969 THEN '1960-1969'
            WHEN YEAR_OF_BIRTH BETWEEN 1970 AND 1979 THEN '1970-1979'
            WHEN YEAR_OF_BIRTH BETWEEN 1980 AND 1989 THEN '1980-1989'
            WHEN YEAR_OF_BIRTH BETWEEN 1990 AND 1999 THEN '1990-1999'
            WHEN YEAR_OF_BIRTH BETWEEN 2000 AND 2009 THEN '2000-2009'
            WHEN YEAR_OF_BIRTH BETWEEN 2010 AND 2019 THEN '2010-2019'
            WHEN YEAR_OF_BIRTH BETWEEN 2020 AND 2029 THEN '2020-2029'
            ELSE 'Unknown'
        END AS AGE_GROUP
    FROM combined_data
    WHERE YEAR_OF_BIRTH IS NOT NULL
),
os_distribution_by_age AS (
    SELECT 
        AGE_GROUP,
        OS_NAME,
        COUNT(DISTINCT MSISDN) AS customer_count
    FROM cleaned_data
    GROUP BY AGE_GROUP, OS_NAME
)
SELECT 
    AGE_GROUP,
    OS_NAME,
    customer_count
FROM os_distribution_by_age
ORDER BY AGE_GROUP, OS_NAME
