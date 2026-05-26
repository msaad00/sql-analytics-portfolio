--Problem:
  Write a query that returns average earnings per order segmented by weekday and hour. 
  For calculating the time period use 'Customer placed order datetime' field. Earnings value is 'Order total' field
    
       Table: doordash_delivery
         columns: 
             customer_placed_order_datetime: datetime
             placed_order_with_restaurant_datetime: datetime
             driver_at_restaurant_datetime: datetime
             delivered_to_consumer_datetime: datetime
             driver_id: int
             restaurant_id: int
             consumer_id: int
             is_new: bool
             delivery_region: varchar
             is_asap: bool
             order_total: float
             discount_amount: int
             tip_amount: float
             refunded_amount: float
         
         
 --Solution: 
 
      SELECT extract(isodow from Customer_placed_order_datetime) as weekday,
             extract(hour from Customer_placed_order_datetime) as hour,
             avg(order_total) as avg_order_total
      FROM doordash_delivery
      GROUP BY 1,2;;
