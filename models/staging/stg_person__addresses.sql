with

source as (
    select * from {{ source('adventure_works', 'person_address') }}
),

renamed as (
    select
        cast(addressid as bigint)         as address_id,
        cast(stateprovinceid as bigint)   as state_province_id,
        addressline1                      as address_line_1,
        addressline2                      as address_line_2,
        city                              as city,
        postalcode                        as postal_code,
        cast(modifieddate as date)   as modified_at
    from source
)

select * from renamed