with 
    all_customers as ( select * from {{ source('jaffle_shop', 'customers') }}),

customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from all_customers
)
select *
from customers
