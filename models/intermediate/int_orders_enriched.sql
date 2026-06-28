with
order_headers as (
    select * from {{ ref('stg_sales__salesorderheaders') }}
),

order_details as (
    select * from {{ ref('stg_sales__salesorderdetails') }}
),

order_header_reasons as (
    select
        *
    from {{ ref('stg_sales__salesorderheadersalesreasons') }}
),

order_reasons as (
    select
        *
    from {{ ref('stg_sales__salesreasons') }}
),

credit_cards as (
    select * from {{ ref('stg_sales__creditcards') }}
),

enriched as (

    select
        oh.*,
        od.sales_order_detail_id,
        od.product_id,
        od.special_offer_id,
        od.carrier_tracking_number,
        od.order_quantity,
        od.unit_price,
        od.unit_price_discount,
        od.unit_price * od.unit_price_discount * od.order_quantity as discount_amount,
        or.sales_reason_nm,
        or.reason_type,
        cc.card_type
    from order_headers oh
    left join order_details od
        on od.sales_order_id = oh.sales_order_id
    left join order_header_reasons ohr
        on od.sales_order_id = ohr.sales_order_id
    left join order_reasons or
        on or.sales_reason_id = ohr.sales_reason_id
    left join credit_cards cc
        on oh.credit_card_id = cc.credit_card_id

)

select * from enriched