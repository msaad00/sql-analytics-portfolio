--Problem:
    For each merchant, find how many orders and first-time orders they had. 
    First-time orders are meant from the perspective of a customer and are the first order that a customer ever made.
    In order words, for how many customers was this the first-ever merchant they ordered with?
    
    Output the name of the merchant, the total number of their orders and the number of these orders that were first-time orders.
    
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
     WITH first_orders
          as (SELECT  *,
                      row_number() over (PARTITION BY customer_id 
                                       ORDER BY order_timestamp asc) 
                                       as rnk
              FROM doordash_orders)
        
        
  SELET name,
         COUNT(*) as total_number_of_orders,
         SUM(CASE WHEN rnk = 1 THEN 1 ELSE 0 END) as first_time_orders
  FROM first_orders fo
  JOIN doordash_merchants ddm 
  ON fo.merchant_id = ddm.id
  GROUP BY 1;
