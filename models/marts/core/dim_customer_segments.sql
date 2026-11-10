with 
    customers as ( select * from {{ref('stg_customers')}}),

final as (

    select
        customers.customer_id,
        customers.first_name,
        case
            when upper(substr(customers.first_name, 1, 1)) between 'A' and 'M' then 'Group A'
            else 'Group B'
        end as customer_segment

    from customers

)

select * from final
