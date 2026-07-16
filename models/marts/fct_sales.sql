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
        details.sales_order_id,
        details.sales_order_detail_id,
        details.product_id,
        details.customer_id,
        details.ship_to_address_id as geography_id,
        details.credit_card_id,

        details.sales_status,
        details.is_online_order,

        details.ordered_at,
        details.shipped_at,

        details.order_qty,
        details.unit_price,
        details.unit_price_discount,
        details.discount_amount,
        details.sales_amount

    from order_details as details
    left join order_reasons as reasons
        on details.sales_order_id = reasons.sales_order_id
)

select * from final