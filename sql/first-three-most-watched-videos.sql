--Problem:
     After a new user creates an account and starts watching videos, the user ID, video ID, and date watched are captured in the database. 
     Find the top 3 videos most users have watched as their first 3 videos. 
     Output the video ID and the number of times it has been watched as the users' first 3 videos.
     In the event of a tie, output all the videos in the top 3 that users watched as their first 3 videos.
     
       Table: videos_watched
        columns:
          user_id: varchar
          video_id: varchar
          watched_at: datetime
         
 --Solution: 
    
    WITH vid_rnk as (
                    SELECT *,
                           dense_rank() over (partition by user_id 
                                              order by watched_at asc) as vid_number
                    FROM videos_watched)

    SELECT
          video_id,
          SUM(CASE WHEN vid_number <= 3 THEN 1 ELSE 0 END)as total_times_watched_top3
    FROM vid_rnk
    GROUP BY 1
    ORDER BY SUM(CASE WHEN vid_number <= 3 THEN 1 ELSE 0 END) DESC
    LIMIT 3;
