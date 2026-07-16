with sales_audit as (
    select
        sum(sales_amount) as total_gross_revevue_2011
    from {{ ref('fct_sales') }}

    where date_part('year', ordered_at) = 2011
)

select
    total_gross_revevue_2011
from sales_audit
where round(total_gross_revevue_2011, 2) != 12645231.0