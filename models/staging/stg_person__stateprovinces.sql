with
source as (
    select * from {{ source('adventure_works', 'person_stateprovince') }}
),

renamed as (

    select
        cast(stateprovinceid as bigint)      as state_province_id,
        cast(territoryid as bigint)          as territory_id,
        stateprovincecode                    as state_province_code,
        countryregioncode                    as country_region_code,
        name                                 as state_province_name,
        cast(isonlystateprovinceflag as boolean) as is_only_state_province,
        cast(modifieddate as timestamp)      as modified_at
    from source
)

select * from renamed