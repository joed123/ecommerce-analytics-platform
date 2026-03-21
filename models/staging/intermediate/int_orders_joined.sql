with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

order_totals as (
    select
        order_id,
        sum(price) as total_price,
        sum(freight_value) as total_freight,
        sum(price + freight_value) as total_order_value,
        count(order_item_id) as total_items
    from order_items
    group by order_id
),

joined as (
    select
        o.order_id,
        o.customer_id,
        o.order_status,
        o.order_purchase_timestamp,
        o.order_approved_at,
        o.order_delivered_carrier_date,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        ot.total_price,
        ot.total_freight,
        ot.total_order_value,
        ot.total_items
    from orders o
    left join customers c on o.customer_id = c.customer_id
    left join order_totals ot on o.order_id = ot.order_id
)

select * from joined