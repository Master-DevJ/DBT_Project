-- models/cleaned_crm_data.sql

with raw_data as (
    select 
        MSISDN,
        GENDER,
        YEAR_OF_BIRTH,
        SYSTEM_STATUS,
        MOBILE_TYPE,
        VALUE_SEGMENT
    from crm_data_unclean
),

standardized_gender as (
    select 
        MSISDN,
        case 
            when upper(GENDER) in ('MALE', 'M', 'M.', 'MALE.', 'MALE`', 'MFEALE', 'MALF', 'MALFE', 'MAFLE', 'MALFE`') then 'Male'
            when upper(GENDER) in ('FEMALE', 'F', 'F.', 'FEMALE.', 'FEMALE`', 'FEMALE]', 'FEMALE..', 'FEMALE3', 'FEMALEF', 'FEMALE\\', 'FEMALEH', 'FEMALE]', 'FEMALE\\', 'FEMALE..', 'FAMALE', 'FEMAL', 'FEMAL`', 'FEM', 'FEMEL', 'FEMELE', 'FEMALE', 'FEMALE..', 'FEMAL]', 'FEMAL`', 'FEMA', 'FEM', 'FEMA', 'FEMEAL', 'FEMALE') then 'Female'
            else 'Others'
        end as GENDER,
        case 
            when YEAR_OF_BIRTH is not null and YEAR_OF_BIRTH between 1900 and 2024 then YEAR_OF_BIRTH
        end as YEAR_OF_BIRTH,
        SYSTEM_STATUS,
        MOBILE_TYPE,
        VALUE_SEGMENT
    from raw_data
),

cleaned_data as (
    select 
        MSISDN,
        coalesce(GENDER, 'Others') as GENDER,
        coalesce(YEAR_OF_BIRTH, 0) as YEAR_OF_BIRTH, -- Assuming 0 is the default for others birth years
        coalesce(SYSTEM_STATUS, 'others') as SYSTEM_STATUS,
        coalesce(MOBILE_TYPE, 'others') as MOBILE_TYPE,
        coalesce(VALUE_SEGMENT, 'others') as VALUE_SEGMENT
    from standardized_gender
)

select * from cleaned_data
