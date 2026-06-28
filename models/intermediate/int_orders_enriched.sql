with
order_details as (
    select * from {{ ref('stg_sales__orderdetails') }}
),

order_headers as (

    select * from {{ ref('stg_adventureworks__sales_order_headers') }}

),

order_reasons as (

    -- um pedido pode ter múltiplos motivos; pegamos o primeiro por simplicidade
    -- se a regra de negócio mudar, o ajuste fica isolado aqui
    select
        sales_order_id,
        min(sales_reason_id) as sales_reason_id
    from {{ ref('stg_adventureworks__sales_order_reasons') }}
    group by sales_order_id

),

credit_cards as (

    select * from {{ ref('stg_adventureworks__credit_cards') }}

),

enriched as (

    select
        -- grain: linha de pedido
        od.sales_order_detail_id,
        od.sales_order_id,

        -- do header
        oh.order_date,
        oh.order_status,
        oh.customer_id,
        oh.bill_to_address_id,
        oh.is_online_order,

        -- cartão (pode vir direto do header ou via person_credit_card)
        coalesce(oh.credit_card_id, null) as credit_card_id,
        cc.card_type,

        -- motivo de venda
        or_.sales_reason_id,

        -- do detail
        od.product_id,
        od.special_offer_id,
        od.order_qty,
        od.unit_price,
        od.unit_price_discount,
        od.line_total,

        -- métrica derivada (computação básica, apropriada aqui)
        od.unit_price * od.unit_price_discount * od.order_qty as discount_amount

    from order_details od
    inner join order_headers oh
        on od.sales_order_id = oh.sales_order_id
    left join order_reasons or_
        on od.sales_order_id = or_.sales_order_id
    left join credit_cards cc
        on oh.credit_card_id = cc.credit_card_id

)

select * from enriched