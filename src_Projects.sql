{% snapshot src_Projects %}

{{
    config(
      target_database='postgres',
      target_schema='ods',
      unique_key='GUIDProject',
      strategy='check',
        check_cols = 'all',
      updated_at='dataflow_dttm',
      invalidate_hard_deletes=True,
    )
}}
SELECT guidproject, project, deleted, guidfskregion, guidfskbrand, optionaccountingobjectsrealestate, isgroup, guidadressgroup, active, exceptionfordailyreport, isprime, isdsk, objectsaccountingoption, dataflow_dttm
FROM ods."projects"

{% endsnapshot %}

