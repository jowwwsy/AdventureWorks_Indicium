with

order_reasons as (
    select
        *
    from {{ ref('stg_sales__salesreasons') }}
),

order_header_reasons as (
    select
        sales_order_id,
        sales_reason_id
    from {{ ref('stg_sales__salesorderheadersalesreasons') }}
),

orders_with_reason as (
    select
        ohr.sales_order_id,
        ohr.sales_reason_id,
        reasons.sales_reason_nm,
        reasons.reason_type
    from order_header_reasons as ohr
    left join order_reasons as reasons
        on reasons.sales_reason_id = ohr.sales_reason_id
),

orders_agg as (
    select
        sales_order_id,
        array_distinct(array_agg(sales_reason_id)) as agg_sales_reason_id,
        array_distinct(array_agg(sales_reason_nm)) as agg_sales_reason_nm,
        array_distinct(array_agg(reason_type)) as agg_reason_type
    from orders_with_reason
    group by sales_order_id
)

select * from orders_agg