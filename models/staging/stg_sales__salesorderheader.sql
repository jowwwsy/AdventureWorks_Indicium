with source as (
    select * FROM {{ source('adventure_works', 'sales_salesorderheader') }}
),

transformed as (
    select
        cast(salesorderid       as integer)                  as sales_order_id,
        cast(customerid         as integer)                  as customer_id,
        cast(territoryid        as integer)                  as territory_id,
        cast(billtoaddressid    as integer)                  as bill_to_address_id,
        cast(shiptoaddressid    as integer)                  as ship_to_address_id,
        cast(shipmethodid       as integer)                  as ship_method_id,
        cast(salespersonid      as integer)                  as salesperson_id,
        cast(creditcardid       as integer)                  as credit_card_id,
        cast(currencyrateid     as integer)                  as currency_rate_id,
        purchaseordernumber                as purchase_order_number,
        accountnumber                      as account_number,
        creditcardapprovalcode             as credit_card_approval_code,
        rowguid                            as row_guid,
        comment                            as comment,
        cast(revisionnumber     as integer)                 as revision_number,
        cast(status             as integer)                 as sales_status,
        cast(subtotal           as double)                  as subtotal,
        cast(taxamt             as double)                  as tax_amount,
        cast(freight            as double)                  as freight,
        cast(totaldue           as double)                  as total_due,
        cast(onlineorderflag    as boolean)                 as is_online_order,
        cast(orderdate          as date)               as ordered_at,
        cast(duedate            as date)               as due_at,
        cast(shipdate           as date)               as shipped_at,
        cast(modifieddate       as date)               as modified_at
    from source
)

SELECT * from transformed