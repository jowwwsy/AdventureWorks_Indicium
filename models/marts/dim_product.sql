{{
  config(
    materialized = 'table'
  )
}}

with

products as (
    select * from {{ ref('int_products_enriched') }}
),


null_treatment as (
    select
        product_id,
        product_nm,
        product_number,
        color,
        list_price,
        standard_cost,
        sell_start_date,
        sell_end_date,
        coalesce(subcategory_nm, 'No Subcategory') as subcategory_nm,
        coalesce(category_nm,     'No Category')    as category_nm
    from products p
)

select * from null_treatment