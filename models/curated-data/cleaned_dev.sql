with raw_data as (
    select 
        MSISDN,
        IMEI_TAC,
        BRAND_NAME,
        MODEL_NAME,
        OS_NAME,
        OS_VENDOR
    from device_data_unclean
),

-- Find the most frequent os_vendor for each os_name
os_vendor_frequency as (
    select 
        OS_NAME,
        OS_VENDOR,
        count(*) as count
    from raw_data
    where OS_VENDOR is not null and OS_VENDOR != 'Null'
    group by OS_NAME, OS_VENDOR
),

-- Get the most frequent os_vendor for each os_name
most_frequent_os_vendor as (
    select 
        OS_NAME,
        OS_VENDOR
    from (
        select 
            OS_NAME,
            OS_VENDOR,
            row_number() over (partition by OS_NAME order by count desc) as row_num
        from os_vendor_frequency
    ) as ranked
    where row_num = 1
),

-- Join the most frequent os_vendor with raw data
data_with_os_vendor as (
    select 
        raw_data.MSISDN,
        raw_data.IMEI_TAC,
        raw_data.BRAND_NAME,
        raw_data.MODEL_NAME,
        raw_data.OS_NAME,
        coalesce(
            nullif(raw_data.OS_VENDOR, 'Null'),
            most_frequent_os_vendor.OS_VENDOR
        ) as OS_VENDOR
    from raw_data
    left join most_frequent_os_vendor
    on raw_data.OS_NAME = most_frequent_os_vendor.OS_NAME
),

-- Find the most frequent os_name for each brand_name
os_name_frequency as (
    select 
        BRAND_NAME,
        OS_NAME,
        count(*) as count
    from data_with_os_vendor
    where OS_NAME is not null and OS_NAME != 'Null'
    group by BRAND_NAME, OS_NAME
),

-- Get the most frequent os_name for each brand_name
most_frequent_os_name as (
    select 
        BRAND_NAME,
        OS_NAME
    from (
        select 
            BRAND_NAME,
            OS_NAME,
            row_number() over (partition by BRAND_NAME order by count desc) as row_num
        from os_name_frequency
    ) as ranked
    where row_num = 1
),

-- Join the most frequent os_name with data_with_os_vendor
final_cleaned_data as (
    select 
        data_with_os_vendor.MSISDN,
        data_with_os_vendor.IMEI_TAC,
        data_with_os_vendor.BRAND_NAME,
        data_with_os_vendor.MODEL_NAME,
        coalesce(
            nullif(data_with_os_vendor.OS_NAME, 'Null'),
            most_frequent_os_name.OS_NAME
        ) as OS_NAME,
        data_with_os_vendor.OS_VENDOR
    from data_with_os_vendor
    left join most_frequent_os_name
    on data_with_os_vendor.BRAND_NAME = most_frequent_os_name.BRAND_NAME
)

-- Final cleaned data with 'Others' as default for remaining nulls
select 
    MSISDN,
    IMEI_TAC,
    coalesce(BRAND_NAME, 'Others') as BRAND_NAME,
    coalesce(MODEL_NAME, 'Others') as MODEL_NAME,
    coalesce(OS_NAME, 'Others') as OS_NAME,
    coalesce(OS_VENDOR, 'Others') as OS_VENDOR
from final_cleaned_data;
