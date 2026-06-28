with
order_headers as (
    select * from {{ ref('stg_sales__salesorderheaders') }}
),

order_details as (
    select * from {{ ref('stg_sales__salesorderdetails') }}
),

enriched as (

    select
        oh.*,
        od.sales_order_detail_id,
        od.product_id,
        od.special_offer_id,
        od.carrier_tracking_number,
        od.order_qty,
        od.unit_price,
        od.unit_price_discount,
        od.order_qty*od.unit_price as sales_amount,
        od.unit_price * od.unit_price_discount * od.order_qty as discount_amount
    from order_headers oh
    left join order_details od
        on od.sales_order_id = oh.sales_order_id
)

select * from enriched