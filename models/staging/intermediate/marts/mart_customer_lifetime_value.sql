with orders as (
    select * from {{ ref('int_orders_joined') }}
),

payments as (
    select * from {{ ref('stg_order_payments') }}
),

customer_payments as (
    select
        o.customer_unique_id,
        o.customer_city,
        o.customer_state,
        count(distinct o.order_id) as total_orders,
        round(sum(p.payment_value), 2) as total_spent,
        round(avg(p.payment_value), 2) as avg_order_value,
        min(o.order_purchase_timestamp) as first_order_date,
        max(o.order_purchase_timestamp) as last_order_date
    from orders o
    left join payments p on o.order_id = p.order_id
    where o.order_status = 'delivered'
    group by o.customer_unique_id, o.customer_city, o.customer_state
)

select * from customer_payments