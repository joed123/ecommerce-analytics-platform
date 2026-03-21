with order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

sellers as (
    select * from {{ ref('stg_sellers') }}
),

reviews as (
    select * from {{ ref('stg_order_reviews') }}
),

seller_metrics as (
    select
        s.seller_id,
        s.seller_city,
        s.seller_state,
        count(distinct o.order_id) as total_orders,
        count(oi.order_item_id) as total_items_sold,
        round(sum(oi.price), 2) as total_revenue,
        round(avg(oi.price), 2) as avg_item_price,
        round(avg(r.review_score), 2) as avg_review_score
    from sellers s
    left join order_items oi on s.seller_id = oi.seller_id
    left join orders o on oi.order_id = o.order_id
    left join reviews r on o.order_id = r.order_id
    where o.order_status = 'delivered'
    group by s.seller_id, s.seller_city, s.seller_state
)

select * from seller_metrics