with cleaned_data as (
    select 
        MSISDN,
        WEEK_NUMBER,
        REVENUE_USD,
        VALUE_SEGMENT,
        YEAR_OF_BIRTH,
        case
            when YEAR_OF_BIRTH >= 1900 and YEAR_OF_BIRTH < 1920 then '1900-1919'
            when YEAR_OF_BIRTH >= 1920 and YEAR_OF_BIRTH < 1930 then '1920-1929'
            when YEAR_OF_BIRTH >= 1930 and YEAR_OF_BIRTH < 1940 then '1930-1939'
            when YEAR_OF_BIRTH >= 1940 and YEAR_OF_BIRTH < 1950 then '1940-1949'
            when YEAR_OF_BIRTH >= 1950 and YEAR_OF_BIRTH < 1960 then '1950-1959'
            when YEAR_OF_BIRTH >= 1960 and YEAR_OF_BIRTH < 1970 then '1960-1969'
            when YEAR_OF_BIRTH >= 1970 and YEAR_OF_BIRTH < 1980 then '1970-1979'
            when YEAR_OF_BIRTH >= 1980 and YEAR_OF_BIRTH < 1990 then '1980-1989'
            when YEAR_OF_BIRTH >= 1990 and YEAR_OF_BIRTH < 2000 then '1990-1999'
            when YEAR_OF_BIRTH >= 2000 and YEAR_OF_BIRTH < 2010 then '2000-2009'
            when YEAR_OF_BIRTH >= 2010 and YEAR_OF_BIRTH < 2020 then '2010-2019'
            when YEAR_OF_BIRTH >= 2020 and YEAR_OF_BIRTH < 2030 then '2020-2029'
            else 'Unknown' -- Default for unknown birth years
        end as AGE_GROUP
    from combined_data
)

select 
    AGE_GROUP,
    coalesce(VALUE_SEGMENT, 'Tier 3') as VALUE_SEGMENT,
    sum(REVENUE_USD) as total_revenue
from cleaned_data
group by AGE_GROUP, VALUE_SEGMENT