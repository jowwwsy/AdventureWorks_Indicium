{{
  config(
    materialized = 'table'
  )
}}

with

sales_reasons as (
    select
        sales_order_id,
        agg_sales_reason_nm,
        agg_reason_type
    from {{ ref('int_sales_reason') }}
)

select * from sales_reasons
