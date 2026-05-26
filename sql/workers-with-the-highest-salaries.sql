--Problem:
     Find the titles of workers that earn the highest salary. 
     Output the highest-paid title or multiple titles that share the highest salary.
       Table: worker
        columns:
         worker_id: int
         first_name: varchar
         last_name: varchar
         salary: int
         joining_date: datetime
         department: varchar

         
        Table: title
         columns:
          worker_ref_id: int
          worker_title: varchar
          affected_from: datetime
         
 --Solution: 
    WITH salary_ranking as (SELECT w.worker_id,
                                   t.worker_title as title,
                                   w.salary,
                                  dense_rank()over (order by salary DESC) as rnk
                            FROM worker w
                            JOIN title t 
                            ON w.worker_id = t.worker_ref_id)

    SELECT title
    FROM salary_ranking
    WHERE rnk = 1;
