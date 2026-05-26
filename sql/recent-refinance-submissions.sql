--Problem:
     Write a query that joins this submissions table to the loans table and returns the total loan balance on each user’s most recent ‘Refinance’ submission. 
     Return all users and the balance for each of them.
    
       Table: 
        Loans
          columns:
            id: int
            user_id: int
            created_at: datetime
            status:varchar
            type:varchar
            
        Submissions
           columns:
             id: int
             balance: float
             interest_rate: float
             rate_type: varchar
             loan_id: int
         
 --Solution: 
       with date_ranking as (SELECT *,
                                    rank() over (partition by user_id order by created_at DESC) as date_rank
                             FROM loans
                             WHERE type = 'Refinance')
                      
     SELECT user_id,
            sum(balance) as total_balance
     FROM date_ranking dr
     JOIN submissions s 
     ON dr.id = s.loan_id
     WHERE date_rank = 1
     GROUP BY 1;
