--Problem:
    Calculate the total revenue made per book.Output the book ID and total sales per book.
    In case there is a book that has never been sold, include it in your output with a value of 0.
    
       Table: 
         amazon_books
           columns:
             book_id: int
             book_title: varchar
             unit_price: int
             
         amazon_books_order_details
           columns:
             order_details_id: int
             order_id: int
             book_id: int
             quantity: int
         
         
 --Solution: 
 
    SELECT ab.book_id,
           COALESCE(SUM(ab.unit_price * abs.quantity),'0') as total_sales
    FROM amazon_books ab
    LEFT JOIN amazon_books_order_details abs 
    ON ab.book_id = abs.book_id
    GROUP BY 1;
