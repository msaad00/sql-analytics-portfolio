--Problem:
    Write a query that will return all cities with more customers than the average number of  customers of all cities that have at least one customer. 
    For each such city, return the country name,  the city name, and the number of customers
    
       Table: 
         linkedin_customers
           columns:
             id: int
             business_name:varchar
             city_id: int 
             
         linkedin_city
           columns:
             id: int
             city_name: varchar
             country_id: int 
             
         linkedin_country
           columns:
             id: int
             country_name: varchar
         
         
 --Solution: 
 
     WITH number_of_customers as 
         (SELECT country_name,
                 city_name,
                 count (*) as num_customers
          FROM linkedin_city lc 
          INNER JOIN linkedin_customers lcs
          ON lc.id = lcs.city_id
          JOIN linkedin_country lctr
          ON lc.country_id = lctr.id
          GROUP BY 1,2)


   SELECT country_name,
          city_name,
          num_customers
   FROM number_of_customers
   WHERE num_customers > (SELECT avg (num_customers) 
                           FROM number_of_customers);
