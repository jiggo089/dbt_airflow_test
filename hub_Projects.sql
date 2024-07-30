
{{ config(materialized='table') }}

SELECT DISTINCT
    MD5(CONCAT(GUIDProject)) as hub_key_Projects,  
    GUIDProject,
    '1C' as source_system_dk,
    dataflow_dttm
FROM ods."src_Projects"
