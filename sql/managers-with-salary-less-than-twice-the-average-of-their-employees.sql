--Problem:
     Write a query to get the list of managers whose salary is less than twice the average salary of employees reporting to them. 
     For these managers, output their ID, salary and the average salary of employees reporting to them
       Tables: 
        map_employee_hierarchy
        columns:
        empl_id:varchar
        manager_empl_id:varchar
        
        dim_employee
        columns:
        empl_id:varchar
        empl_name:varchar
        empl_city:varchar
        empl_dob:datetime
        empl_pin:int
        salary:int
         
 --Solution: 
    WITH managers as(
           SELECT
                  m.manager_empl_id as manager,
                  e.empl_id as employee,
                  salary
           FROM dim_employee e
           JOIN map_employee_hierarchy m
           ON e.empl_id = m.manager_empl_id),

mngr_employees_avg as (
         SELECT
             m.manager_empl_id as manager,
             e.empl_id as employee,
             e.salary,
             avg(e.salary) over (partition by manager_empl_id) as avg_empl_pr_mngr
         FROM dim_employee e
         JOIN map_employee_hierarchy m
         ON e.empl_id = m.empl_id)
        
SELECT distinct (me.manager) as manager_id,
       me.salary as manager_salary,
       av.avg_empl_pr_mngr as employees_avg
FROM   managers me
JOIN mngr_employees_avg av
ON me.manager = av.manager
WHERE me.salary < (2 * av.avg_empl_pr_mngr);
