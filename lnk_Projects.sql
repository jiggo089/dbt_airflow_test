
{{ config(materialized='table') }}

SELECT DISTINCT
    MD5(CONCAT(MD5(CONCAT(GUIDProject)))) as link_key_Projects,  
    MD5(CONCAT(GUIDProject)) as hub_key_Projects,
    dataflow_dttm
FROM ods."src_Projects"
