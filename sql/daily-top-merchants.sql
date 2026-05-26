--Problem:
    For each day, find the top 3 merchants with the highest number of orders on that day. 
    In case of a tie, multiple merchants can share the same place but on each day, there should always be at least 1 merchant on the first, 
    second and third place.
    Output the date, the name of the merchant and their place in the daily ranking.
       Table: doordash_orders
                columns:
                  id: int
                 customerid: int
                 merchant_id: int
                 order_timestamp: datetime
                 n_items: int
                 total_amount_earned: float
                 
            doordash_merchants
                 id: int
                 name: varchar
                 category: varchar
                 zipcode: int
            
            
 --Solution: 
    WITH orders_per_day as (SELECT 
                                   to_char(order_timestamp,'YYYY-MM-DD') as order_day,
                                   name,
                                   count(*) as number_of_orders
                           FROM doordash_orders dr
                           JOIN doordash_merchants dm
                           ON dr.merchant_id = dm.id
                           GROUP BY 1,2
                           ORDER BY 3 DESC),


   ranking as (SELECT order_day,
                      name,
                      number_of_orders,
                      dense_rank() over (partition by order_day order by number_of_orders DESC)
                       as rnk
               FROM orders_per_day)

   SELECT order_Day,
          name,
          rnk as ranking
   FROM ranking
   WHERE rnk <= 3;
