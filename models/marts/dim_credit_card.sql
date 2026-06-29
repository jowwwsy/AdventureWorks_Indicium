{{
  config(
    materialized = 'table'
  )
}}

with

credit_cards as (
    select * from {{ ref('stg_sales__creditcards') }}
),

final as (
    select
        credit_card_id,
        card_type
    from credit_cards
)

select * from final