with products as (
    select * from {{ ref('stg_products') }}
),

translations as (
    select * from {{ ref('stg_product_category_translations') }}
),

joined as (
    select
        p.product_id,
        p.product_category_name,
        coalesce(t.product_category_name_english, p.product_category_name) as product_category_name_english,
        p.product_weight_g,
        p.product_length_cm,
        p.product_height_cm,
        p.product_width_cm,
        p.product_photos_qty
    from products p
    left join translations t on p.product_category_name = t.product_category_name
)

select * from joined