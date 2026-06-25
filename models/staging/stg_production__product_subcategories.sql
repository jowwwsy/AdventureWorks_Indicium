with

source as (
    select * from {{ source('adventure_works', 'production_productsubcategory') }}
),

renamed as (
    select
        cast(productsubcategoryid as bigint) as product_subcategory_id,
        cast(productcategoryid as bigint)    as product_category_id,
        name                                 as subcategory_name,
        cast(modifieddate as date)      as modified_at
    from source
)

select * from renamed