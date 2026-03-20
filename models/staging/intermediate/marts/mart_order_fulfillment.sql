with orders as (
    select * from {{ ref('int_orders_joined') }}
),

fulfillment as (
    select
        order_id,
        customer_state,
        order_status,
        order_purchase_timestamp,
        order_delivered_customer_date,
        order_estimated_delivery_date,
        datediff('day', order_purchase_timestamp, order_delivered_customer_date) as actual_delivery_days,
        datediff('day', order_purchase_timestamp, order_estimated_delivery_date) as estimated_delivery_days,
        case
            when order_delivered_customer_date <= order_estimated_delivery_date then 'On Time'
            when order_delivered_customer_date > order_estimated_delivery_date then 'Late'
            else 'Unknown'
        end as delivery_status
    from orders
    where order_status = 'delivered'
)

select * from fulfillment
