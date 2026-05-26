--Problem:
     Find the employee with the highest salary per department.
     Output the department name, employee's first name along with the corresponding salary.
       Table: employee
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
         manager_id:int
         
 --Solution: 
     WITH salary_rank as (SELECT department,
                                 first_name as employee_name,
                                 salary,
                                 rank () over (partition by department order by salary DESC) as salary_rnk
                          FROM employee)
                     
                     
     SELECT *
     FROM salary_rank
     WHERE salary_rnk = 1
     ORDER BY salary DESC;
