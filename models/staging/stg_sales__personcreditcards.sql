with

source as (
    select * from {{ source('adventure_works', 'sales_personcreditcard') }}
),

renamed as (
    select
        cast(businessentityid as bigint) as business_entity_id,
        cast(creditcardid as bigint)     as credit_card_id,
        cast(modifieddate as date)  as modified_at
    from source
)

select * from renamed