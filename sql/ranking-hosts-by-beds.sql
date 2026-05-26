--Problem:
     Rank each host based on the number of beds they have listed. 
     The host with the most beds should be ranked 1 and the host with the least number of beds should be ranked last. 
     Hosts that have the same number of beds should have the same rank but there should be no gaps between ranking values. 
     A host can also own multiple properties.
     Output the host ID, number of beds, and rank from highest rank to lowest.
       Table: airbnb_apartments
        columns:
          host_id: int
          apartment_id: varchar
          apartment_type: varchar
          n_beds: int
          n_bedrooms: int
          country:varchar
          city: varchar
         
 --Solution: 

     SELECT host_id,
            sum(n_beds),
            dense_rank() over (order by sum(n_beds) desc) as rnk
     FROM airbnb_apartments
     GROUP BY 1;
