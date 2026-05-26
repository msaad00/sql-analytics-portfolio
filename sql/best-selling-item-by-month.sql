--Problem:
     Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. 
     The best selling item is calculated using the formula (unitprice * quantity). 
     Output the description of the item along with the amount paid.
       Table: invoices
        columns:
         invoiceno:varchar
         stockcode:varchar
         description:varchar
         quantity:int
         invoicedate:datetime
         unitprice:float
         customerid:float
         country:varchar
         
 --Solution: 
    WITH online_retail_amount AS(
        SELECT *,
               quantity * unitprice AS amount,
               DATE_PART('month', invoicedate) AS month
        FROM online_retail
),
 monthly_total_by_product AS(
      SELECT 
         month, 
         description,
         SUM(amount) AS total_amount
     FROM online_retail_amount
     GROUP BY month, description
),
monthly_ranking AS (
    SELECT 
         month, 
         description, 
         total_amount,
         RANK() OVER(PARTITION BY month ORDER BY total_amount DESC) AS rank
    FROM monthly_total_by_product
)

SELECT month,
       description, 
       total_amount
FROM monthly_ranking
WHERE rank = 1
ORDER BY MONTH;
