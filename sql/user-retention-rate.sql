--Problem:
   Calculate the first-day retention rate of a group of video game players. 
   The first-day retention occurs when a player logs in 1 day after their first-ever log-in.
   Return the proportion of players who meet this definition divided by the total number of players.
      Table: players_login
        Columns:
         player_id:
         int
         login_date:
         datetime
         
--Solution: 
with first_next_login as (
    SELECT
       distinct(player_id),
       min (login_date) over (partition by player_id order by login_date) 
       as first_login,
       lead (login_date) over (partition by player_id order by login_date)
       as next_login,
       lead (login_date) over (partition by player_id order by login_date)
       - min (login_date) over (partition by player_id order by login_date)as diff
    FROM players_logins),

retention_users as (
      SELECT 
       sum(CASE WHEN diff = 1 THEN 1 ELSE 0 END) as retention_user
      FROM first_next_login),

all_users as (
       SELECT count (distinct(player_id)) as total_users
       FROM players_logins)

SELECT CAST(retention_user as float)/ cast(total_users as float) *100 as retention_rate
FROM retention_users,all_users;


