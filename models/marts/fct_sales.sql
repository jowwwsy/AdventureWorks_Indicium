{{
  config(
    materialized   = 'table',
    unique_key     = 'sales_order_detail_id'
  )
}}

with

order_details as (
    select * from {{ ref('int_orders_enriched') }}
),

order_reasons as (
    select * from {{ ref('int_sales_reason') }}
),

final as (
    select
        od.sales_order_id,
        od.sales_order_detail_id,
        od.product_id,
        od.customer_id,
        od.ship_to_address_id as geography_id,
        od.credit_card_id,
        or.sales_reason_id,

        od.sales_status,
        od.is_online_order,

        od.ordered_at,
        od.shipped_at,

        od.order_qty,
        od.unit_price,
        od.unit_price_discount,
        od.discount_amount,
        round((od.sales_amount - od.discount_amount),2)                                          as gross_revenue


    from order_details od
    left join order_reasons or
        on od.sales_order_id = or.sales_order_id
)

select * from final