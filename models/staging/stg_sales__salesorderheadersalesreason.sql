with

source as (
    select * from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}
),

renamed as (
    select
        cast(salesorderid as bigint)    as salesorderheader_id,
        cast(salesreasonid as bigint)   as salesreason_id,
        cast(modifieddate as date) as modified_at
    from source
)

select * from renamed