with 
    all_payments as ( select * from {{ source('stripe', 'payment') }}),
    payments as (
        select 
            id as payment_id,
            orderid as order_id, 
            paymentmethod, 
            status, 
            amount, 
            created,
            _batched_at

        from all_payments
    )
select *
from payments
