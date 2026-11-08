with 
    payments as ( select * from {{ref('stg_payments')}}),
    orders as (select * from {{ref('stg_orders')}}), 

    fct_orders as (
        select 
            orders.order_id,
            payments.payment_id,
            payments.amount 
        from orders  
        left join payments 
        on orders.order_id = payments.order_id
    )

select * from fct_orders