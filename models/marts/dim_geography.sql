{{
  config(
    materialized = 'table'
  )
}}

with

addresses as (
    select * from {{ ref('stg_person__addresses') }}
),

state_provinces as (
    select * from {{ ref('stg_person__stateprovinces') }}
),

country_regions as (
    select * from {{ ref('stg_person__countryregions') }}
),

final as (
    select
        a.address_id                    as geography_id,
        a.city,
        a.postal_code,
        sp.state_province_nm,
        sp.state_province_code,
        cr.country_region_nm,
        cr.country_region_code
    from addresses a
    left join state_provinces sp
        on a.state_province_id = sp.state_province_id
    left join country_regions cr
        on sp.country_region_code = cr.country_region_code
)

select * from final
