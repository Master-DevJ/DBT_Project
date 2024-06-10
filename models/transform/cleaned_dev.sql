-- models/cleaned_device_data.sql

with raw_data as (
    select 
        MSISDN,
        IMEI_TAC,
        BRAND_NAME,
        MODEL_NAME,
        OS_NAME,
        OS_VENDOR
    from device_data_unclean
)

, cleaned_data as (
    select 
        MSISDN,
        IMEI_TAC,
        coalesce(BRAND_NAME, 'Others') as BRAND_NAME,
        coalesce(MODEL_NAME, 'Others') as MODEL_NAME,
        coalesce(OS_NAME, 'Others') as OS_NAME,
        coalesce(OS_VENDOR, 'Others') as OS_VENDOR
    from raw_data
)

select * from cleaned_data
