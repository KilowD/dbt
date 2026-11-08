{{ config(
    materialized='incremental',
    unique_key='payment_id'
) }}

with
{% if is_incremental() %}
cutoff as (
    select max(order_date) as max_order_date
    from {{ this }}
),
{% endif %}

payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select orders.*
    from {{ ref('stg_orders') }} as orders
    {% if is_incremental() %}
    inner join cutoff
        on orders.order_date >= cutoff.max_order_date
    {% endif %}
),

customers as (
    select * from {{ ref('dim_customers') }}
),

fct_orders as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        payments.payment_id,
        payments.amount
    from orders
    left join payments
        on orders.order_id = payments.order_id
    left join customers
        on orders.customer_id = customers.customer_id
)

select * from fct_orders