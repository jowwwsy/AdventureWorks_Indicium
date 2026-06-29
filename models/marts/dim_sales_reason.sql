{{
  config(
    materialized = 'table'
  )
}}

with

sales_reasons as (
    select
        sales_reason_id,
        sales_reason_nm,
        reason_type
    from {{ ref('stg_sales__salesreasons') }}
)

select * from sales_reasons
