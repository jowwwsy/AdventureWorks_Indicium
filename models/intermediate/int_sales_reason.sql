with

order_reasons as (
    select
        *
    from {{ ref('stg_sales__salesreasons') }} 
),

order_header_reasons as (
    select
        sales_order_id,
        min(sales_reason_id) as sales_reason_id
    from {{ ref('stg_sales__salesorderheadersalesreasons') }}
    group by sales_order_id
),

orders_with_reason as (
    select
        ohr.sales_order_id,
        or.sales_reason_nm,
        or.reason_type
    from order_header_reasons ohr
    left join order_reasons or
        on or.sales_reason_id = ohr.sales_reason_id
)

select * from orders_with_reason