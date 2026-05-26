--Problem:
    Find the unique room types(filter room types column). Output each unique room types in its own row.
    
       Table: 
         airbnb_searches
           columns:
             ds: datetime
             id_user: varchar
             ds_checkin: datetime
             ds_checkout: datetime
             n_searches: int
             n_nights: float
             n_guests_min: int
             n_guests_max: int
             origin_country: varchar
             filter_price_min: float
             filter_price_max: float
             filter_room_types: varchar
             filter_neighborhoods: datetime
         
         
 --Solution: 
 
    SELECT property_type 
    FROM (
          SELECT
                DISTINCT(unnest(string_to_array(filter_room_types,','))) as property_type
          FROM airbnb_searches) s
    WHERE property_type is not null
    AND   property_type <> '';
