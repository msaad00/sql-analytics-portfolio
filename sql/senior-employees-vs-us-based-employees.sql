--Problem:
    Find whether the number of senior workers (i.e., more experienced) at Meta/Facebook is higher than number of USA based employees at Facebook/Meta.
    If the number of seniors is higher then output as 'More seniors'. Otherwise, output as 'More USA-based'.
    
       Table:  facebook_employees
        columns:
         id: int
         location: varchar
         age: int
         gender: varchar
         is_senior: bool
         
         
         
 --Solution: 
      SELECT (CASE 
             WHEN
            SUM(CASE WHEN is_senior = 'True' THEN 1 ELSE 0 END)
            >
            SUM(CASE WHEN location = 'USA' THEN 1 ELSE 0 END) THEN 
            'More seniors' ELSE ' More USA-based' END) AS result
      FROM facebook_employees;
