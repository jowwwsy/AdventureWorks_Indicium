with source as (
    select * from {{ source('adventure_works', 'sales_customer') }}
),

transformed as (
    select
        cast(customerid as integer)      as customer_id,
        cast(personid as integer)       as person_id,
        cast(storeid as integer)         as store_id,
        cast(territoryid as integer)     as territory_id,
        rowguid as row_guid,
        cast(modifieddate as timestamp)    as modified_at
    from source
)

select * from transformed