--SQL Project 

DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify(
    artist VARCHAR(300),
	track VARCHAR(300),
	album VARCHAR(300),
	album_type VARCHAR(50),
	danceability FLOAT,
	energy FLOAT,
	loudness FLOAT,
	speechiness FLOAT,
	acousticness FLOAT,
	instrumentalness FLOAT,
	liveness FLOAT,
	valence FLOAT,
	tempo FLOAT,
	duration_min FLOAT,
	title VARCHAR(500),
	channel VARCHAR(500),
	views FLOAT,
	likes BIGINT,
	comments FLOAT,
	licensed BOOLEAN,
	official_video BOOLEAN,
	stream BIGINT,
	energy_liveness FLOAT,
	most_played_on VARCHAR(50)
);

--EDA
SELECT COUNT(DISTINCT artist) FROM spotify;
SELECT DISTINCT artist FROM spotify;

SELECT COUNT (DISTINCT album) FROM spotify;
SELECT DISTINCT album FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT * FROM spotify
WHERE duration_min =0;

SELECT * FROM spotify
WHERE duration_min = (SELECT MAX(duration_min) FROM spotify);


DELETE FROM spotify
WHERE duration_min =0;
SELECT * FROM spotify
WHERE duration_min =0;

SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT channel) FROM spotify;
SELECT DISTINCT channel FROM spotify;

--NAMES OF ALL TRACKS THAT HAVE MORE THAN 1 BILLION STREAMS.
SELECT track FROM spotify
WHERE stream > 1000000000; 

SELECT * FROM spotify;

--ALBUMS ALONG WITH THEIR RESPECTIVE ARTISTS.
SELECT album,artist FROM spotify;


--TOTAL NUMBER OF COMMENTS FOR TRACKS WHERE LICENSED='TRUE'
SELECT COUNT(comments) FROM spotify
WHERE licensed = TRUE;

--AVERAGE DANCEABILITY OF TRACKS IN EACH ALBUM.
SELECT album,
avg(danceability) as avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;

SELECT*FROM spotify;

--TOP 5 TRACKS WITH THE HIGHEST ENERGY VALUES.
SELECT track,
MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

SELECT * FROM spotify;

--ALL TRACKS ALONG WITH THEIR VIEWS AND LIKES WHERE OFFICIAL_VIDEO=TRUE.
SELECT 
    track,
    SUM(views) as total_views,
    SUM(likes) as  total_likes
FROM spotify
WHERE official_video =TRUE
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

SELECT * FROM spotify;


--FOR EACH ALBUM , TOTAL VIEWS OF ALL ASSOCIATED TRACKS.
SELECT album,track,
SUM(views) as total_views
FROM spotify
GROUP BY 1,2;

SELECT*FROM spotify;

--TRACKS THAT  HAVE BEEN STREAMED ON SPOTIFY MORE THAN YOUTUBE.
SELECT track,
SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END) as streamed_on_youtube,
SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END) as streamed_on_spotify
FROM spotify
GROUP BY 1;

SELECT*FROM spotify;

--TOP 3 MOST-VIEWED TRACKS FOR EACH ARTIST 
WITH ranking_artist
AS
(SELECT artist,track,
    SUM(views) as total_view,
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views)DESC) as rank
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC
)
SELECT*FROM ranking_artist
WHERE rank<=3;

SELECT*FROM spotify;

--TRACKS WHERE THE LIVENESS SCORE IS ABOVE THE AVERAGE.
SELECT AVG(liveness) FROM spotify;

SELECT * FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);

SELECT * FROM spotify;

--DIFFERENCE BETWEEN THE HIGHEST ENERGY VALUES AND LOWEST ENERGY VALUES FOR TRACKS IN EACH ALBUM.
WITH cte
AS
(SELECT
 album,
 MAX(energy) as highest_energy,
 MIN(energy) as lowest_energy
 FROM spotify
 GROUP BY album
 )
 SELECT
   album,
   highest_energy - lowest_energy as energy_diff
  FROM cte
 ORDER BY 2 DESC;






