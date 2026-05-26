--Problem:
      Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. 
      For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, 
      consider only the latest page_load and earliest page_exit. Output the user_id and their average session time.
      
      Table: facebook_web_log
          columns:
            user_id: int
            timestamp: datetime
            action: varchar


--Solution:
    with min_max as (select user_id,
                            date(timestamp),
                            max(case when action = 'page_load' then timestamp end) as pg_load,
                            min(case when action = 'page_exit' then timestamp end)  as pg_exit
                     from facebook_web_log group by 1,2)

  select user_id,
       avg(pg_exit - pg_load) as avg
  from min_max
  group by 1
  having avg(pg_exit-pg_load) is not null ;
