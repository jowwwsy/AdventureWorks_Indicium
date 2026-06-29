with

source as (
    select * from {{ source('adventure_works', 'production_productcategory') }}
),

renamed as (
    select
        cast(productcategoryid as bigint) as product_category_id,
        name                              as category_nm,
        cast(modifieddate as date)   as modified_at
    from source
)

select * from renamed