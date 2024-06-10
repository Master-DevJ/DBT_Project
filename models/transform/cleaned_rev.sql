-- models/cleaned_revenue_data.sql

with cleaned_data as (
    select
        MSISDN,
        WEEK_NUMBER,
        case
            when REVENUE_USD is null then 0  -- Replace missing values with 0
            else REVENUE_USD
        end as REVENUE_USD
    from rev_data_unclean
    where MSISDN is not null and WEEK_NUMBER is not null  -- Filter out rows with missing MSISDN or WEEK_NUMBER
)

select * from cleaned_data
