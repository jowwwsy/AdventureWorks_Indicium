with

source as (
    select * from {{ source('adventure_works', 'production_product') }}
),

renamed as (
    select
        cast(productid as bigint)            as product_id,
        cast(productsubcategoryid as bigint) as product_subcategory_id,
        cast(productmodelid as bigint)       as product_model_id,
        name                                 as product_nm,
        productnumber                        as product_number,
        color                                as color,
        productline                          as product_line,
        class                                as product_class,
        style                                as product_style,
        sizeunitmeasurecode                  as size_unit_measure_code,
        weightunitmeasurecode                as weight_unit_measure_code,
        size                                 as product_size,
        cast(safetystocklevel as integer)    as safety_stock_level,
        cast(reorderpoint as integer)        as reorder_point,
        cast(standardcost as double)         as standard_cost,
        cast(listprice as double)            as list_price,
        cast(weight as double)               as weight,
        cast(daystomanufacture as integer)   as days_to_manufacture,
        cast(makeflag as boolean)            as is_make,
        cast(finishedgoodsflag as boolean)   as is_finished_good,
        cast(sellstartdate as date)          as sell_start_date,
        cast(sellenddate as date)            as sell_end_date,
        cast(discontinueddate as double)       as discontinued_date,
        cast(modifieddate as timestamp)      as modified_at,
        rowguid as row_guid
    from source
)

select * from renamed