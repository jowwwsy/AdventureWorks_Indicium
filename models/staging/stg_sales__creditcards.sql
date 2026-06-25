with

source as (
    select * from {{ source('adventure_works', 'sales_creditcard') }}
),

renamed as (
    select
        cast(creditcardid as bigint)    as credit_card_id,
        cardtype                        as card_type,
        cardnumber                      as card_number,
        cast(expmonth as integer)       as expiration_month,
        cast(expyear as integer)        as expiration_year,
        cast(modifieddate as date) as modified_at
    from source
)

select * from renamed