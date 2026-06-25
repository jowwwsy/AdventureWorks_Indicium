with

source as (
    select * from {{ source('adventure_works', 'sales_salesreason') }}
),

renamed as (
    select
        cast(salesreasonid as bigint) as salesreason_id,
        name                          as sales_reason_nm,
        reasontype                    as reason_type,
        cast(modifieddate as date) as modified_at
    from source
)

select * from renamed