with order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('int_products_joined') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

joined as (
    select
        p.product_category_name_english,
        count(distinct o.order_id) as total_orders,
        count(oi.order_item_id) as total_items_sold,
        round(sum(oi.price), 2) as total_revenue,
        round(avg(oi.price), 2) as avg_item_price,
        round(sum(oi.freight_value), 2) as total_freight
    from order_items oi
    left join products p on oi.product_id = p.product_id
    left join orders o on oi.order_id = o.order_id
    where o.order_status = 'delivered'
    group by p.product_category_name_english
    order by total_revenue desc
)

select * from joined