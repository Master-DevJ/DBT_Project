-- models/combined_data.sql
{{ config(
    materialized='table' 
) }}

with cleaned_revenue_data as (
    select
        MSISDN,
        WEEK_NUMBER,
        case
            when REVENUE_USD is null then 0  -- Replace missing values with 0
            else REVENUE_USD
        end as REVENUE_USD
    from cleaned_rev
    where MSISDN is not null and WEEK_NUMBER is not null  
),

cleaned_device_data as (
    -- Join device data with additional cleaning steps if needed
    select
        MSISDN,
        IMEI_TAC,
        BRAND_NAME,
        MODEL_NAME,
        OS_NAME,
        OS_VENDOR
    from cleaned_dev
    where MSISDN is not null and IMEI_TAC is not null  
),

cleaned_crm_data as (
    -- Join CRM data with additional cleaning steps if needed
    select
        MSISDN,
        GENDER,
        YEAR_OF_BIRTH,
        SYSTEM_STATUS,
        MOBILE_TYPE,
        VALUE_SEGMENT
    from cleaned_crm
    where MSISDN is not null  
)

select
    r.MSISDN,
    r.WEEK_NUMBER,
    r.REVENUE_USD,
    d.IMEI_TAC,
    d.BRAND_NAME,
    d.MODEL_NAME,
    d.OS_NAME,
    d.OS_VENDOR,
    c.GENDER,
    c.YEAR_OF_BIRTH,
    c.SYSTEM_STATUS,
    c.MOBILE_TYPE,
    c.VALUE_SEGMENT
from cleaned_revenue_data r
left join cleaned_device_data d on r.MSISDN = d.MSISDN
left join cleaned_crm_data c on r.MSISDN = c.MSISDN
