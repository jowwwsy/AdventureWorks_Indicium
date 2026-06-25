with source as (
 
    select * from {{ source('adventure_works', 'sales_salesorderdetail') }}
 
),
 
renamed as (
 
    select
 
        ----------  ids
        cast(salesorderid           as bigint)              as sales_order_id,
        cast(salesorderdetailid     as bigint)              as sales_order_detail_id,
        cast(productid              as bigint)              as product_id,
        cast(specialofferid         as bigint)              as special_offer_id,
 
        carriertrackingnumber                                as carrier_tracking_number,
        rowguid                                              as row_guid,
 
        ----------  numerics
        cast(orderqty               as integer)             as order_quantity,
        cast(unitprice              as double)              as unit_price,
        cast(unitpricediscount      as double)              as unit_price_discount,
 
        ----------  timestamps
        cast(modifieddate           as date)           as modified_at
 
    from source
 
)
 
select * from renamed