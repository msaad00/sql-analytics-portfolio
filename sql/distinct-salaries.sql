
--Problem:
    Find the top three distinct salaries for each department. 
    Output the department name and the top 3 distinct salaries by each department.
    Order your results alphabetically by department and then by highest salary to lowest.
    
       Table: twitter_employee
        columns:
           id: int
           first_name: varchar
           last_name: varchar
           age: int
           sex: varchar
           employee_title: varchar
           department: varchar
           salary: int
           target: int
           bonus: int
           email: varchar
           city: varchar
           address: varchar
           manager_id: int
         
 --Solution: 
 
     WITH salary_ranking as (
          SELECT distinct department as department_name,
                 salary,
                 dense_rank () over (partition by department order by salary DESC) as salary_rnk
          FROM twitter_employee)
                        
                        
                        
    SELECT department_name,
           salary,
           salary_rnk
    FROM salary_ranking
    WHERE salary_rnk <=3
    ORDER BY 1,2 desc;
