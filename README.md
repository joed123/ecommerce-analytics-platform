# Ecommerce Analytics Platform

End-to-end analytics pipeline built on the Olist Brazilian E-Commerce dataset, ingesting 100k+ orders through a modern data stack.

## Architecture
![Architecture Diagram](architecture.png)

## Tech Stack
| Tool | Purpose |
|---|---|
| **Python** | Data ingestion from Kaggle to S3 |
| **AWS S3** | Raw data lake storage |
| **Snowflake** | Cloud data warehouse |
| **dbt** | Data transformation and modeling |
| **Power BI** | Business intelligence dashboards |

## Data Pipeline
1. Python script downloads 9 CSVs from Kaggle (100k+ orders)
2. Raw files uploaded to S3 under `raw/` prefix
3. Snowflake external stage reads directly from S3
4. dbt models transform raw data into analytics-ready tables
5. Power BI connects to Snowflake mart tables for dashboards

## dbt Models

**Staging** — one model per raw table, light cleaning
- `stg_customers`, `stg_orders`, `stg_order_items`, `stg_order_payments`
- `stg_order_reviews`, `stg_products`, `stg_sellers`, `stg_geolocation`
- `stg_product_category_translations`

**Intermediate** — tables joined together
- `int_orders_joined` — orders + customers + items
- `int_products_joined` — products + English category translations

**Marts** — business metrics ready for reporting
- `mart_revenue_by_category`
- `mart_customer_lifetime_value`
- `mart_seller_performance`
- `mart_order_fulfillment`

## Dashboards
[📊 View Full Dashboard PDF](olist-dashboard.pdf)

- **Sales Performance** — revenue by product category
- **Customer Analytics** — lifetime value and order frequency by city
- **Seller Performance** — revenue and review scores per seller
- **Order Fulfillment** — delivery times and on-time performance

## Key Insights
- **Watches & Gifts** and **Health & Beauty** are the top two revenue-generating categories across 97K+ orders
- **São Paulo** is the highest spending city, dominating customer volume and revenue
- **88% of orders are delivered on time**, with an average order value of $157.64
- **RR (Roraima)** has the longest delivery times of any Brazilian state, likely due to its remote northern location
- **June and July** are peak revenue months, suggesting seasonal demand patterns worth targeting for promotions

## Repository Structure
```
ecommerce-analytics-platform/
├── ingestion/
│   └── kaggle_to_s3.py
├── dbt/
│   └── models/
│       ├── staging/
│       ├── intermediate/
│       └── marts/
├── architecture.png
├── olist-dashboard.pdf
├── requirements.txt
└── README.md
```

## Dataset
Olist Brazilian E-Commerce Public Dataset  
kaggle.com/datasets/olistbr/brazilian-ecommerce
