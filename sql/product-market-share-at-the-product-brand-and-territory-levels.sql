-Problem:
     Write a query to find the Market Share at the Product Brand level for each Territory, for Time Period Q4-2021. 
     Market Share is the number of Products of a certain Product Brand brand sold in a territory, 
     divided by the total number of Products sold in this Territory.
     Output the ID of the Territory, name of the Product Brand and the corresponding Market Share in percentages.
     Only include these Product Brands that had at least one sale in a given territory.
       Tables: 
        fct_customer_sales
        columns:
       cust_id:varchar
       prod_sku_id:varcharorder_date:datetime
       order_value:int
       order_id:varchar
        
      map_customer_territory
        columns:
        cust_id:varchar
        territory_id:varchar
       
      dim_product
       columns:
       prod_sku_id:varchar
       prod_sku_name:varchar
       prod_brand:varchar
       market_name:varchar
         
 --Solution: 
     WITH filtered_fct_sales as (
           SELECT cust_id,
                  prod_sku_id
           FROM (
                 SELECT *,
                       'Q' || to_char(order_date,'Q-YYYY') as quarter_year
                 FROM fct_customer_sales) cst_qty
                 WHERE quarter_year = 'Q4-2021'),

territory_brands_sales as (
         SELECT
                t.territory_id,
                prod_brand,
                prod_sku_name,
                count(*) over (partition by prod_brand,territory_id)
                as total_prod_brand_sales,
                count(*) over (partition by territory_id)
                as total_territory_sales
         FROM filtered_fct_sales fs
         JOIN map_customer_territory t
         ON fs.cust_id = t.cust_id
         JOIN dim_product p
         ON fs.prod_sku_id = p.prod_sku_id
         
)

SELECT distinct(territory_id),
       prod_brand,
       cast(total_prod_brand_sales as float)/
       cast(total_territory_sales as float) * 100 ||('%')as market_share
FROM territory_brands_sales


