{{
  config(
    materialized = 'table'
  )
}}

with spine as (
    {{ dbt_utils.date_spine(
        datepart  = 'day',
        start_date = "cast('2005-01-01' as date)",
        end_date   = "cast('2015-12-31' as date)"
    ) }}
),

dates as (
    select
        cast(date_day as date)              as date_id,
        extract(year    from date_day)      as year,
        extract(quarter from date_day)      as quarter,
        extract(month   from date_day)      as month_number,
        extract(day     from date_day)      as day_of_month,
        to_char(date_day, 'MMMM')          as month_name,
        to_char(date_day, 'yyyy-MM')        as year_month,
        extract(dow from date_day)          as day_of_week,
        date_trunc('month', date_day)       as first_day_of_month,
        date_trunc('year',  date_day)       as first_day_of_year
    from spine
)

select * from dates