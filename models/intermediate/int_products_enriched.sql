with
products as (
    select * from {{ ref('stg_production__products') }}
),

subcategories as (
    select * from {{ ref('stg_production__product_subcategories') }}
),

categories as (
    select * from {{ ref('stg_production__product_categories') }}
),

products_with_hierarchy as (
    select
        p.product_id,
        p.product_nm,
        p.product_number,
        p.color,
        p.list_price,
        p.standard_cost,
        p.is_make,
        p.is_finished_good,
        p.sell_start_date,
        p.sell_end_date,
        sc.subcategory_nm,
        c.category_nm
    from products p
    left join subcategories sc
        on p.product_subcategory_id = sc.product_subcategory_id
    left join categories c
        on sc.product_category_id = c.product_category_id
)

select * from products_with_hierarchy