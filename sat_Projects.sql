{{ config(materialized='table') }}

SELECT
    MD5(CONCAT(GUIDProject, GUIDAdressGroup)) as sat_key_Projects,
    MD5(CONCAT(MD5(CONCAT(GUIDProject)))) as link_key_Projects,
    MD5(concat(GUIDAdressGroup,Project,Deleted,GUIDFskRegion,GUIDFskBrand,OptionAccountingObjectsRealEstate,isGroup,Active,ExceptionForDailyReport,IsPrime,IsDSK,ObjectsAccountingOption)) as hashdiff_key,
    GUIDAdressGroup,
    Project,
    Deleted,
    GUIDFskRegion,
    GUIDFskBrand,
    OptionAccountingObjectsRealEstate,
    isGroup,
    Active,
    ExceptionForDailyReport,
    IsPrime,
    IsDSK,
    ObjectsAccountingOption,
    'true' as actual_flg,
    'false' as delete_flg,
    dbt_updated_at as dataflow_dttm,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to
FROM ods."src_Projects"
