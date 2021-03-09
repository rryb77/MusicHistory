-- Select these columns from the songs table
SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song;


-- Select a smaller amount of columns if needed
SELECT
    Id,
    Title,
    ReleaseDate
FROM Song;


-- A shortcut during development to select ALL columns from the table. NOT FOR USE in final production code
SELECT * FROM Song;


-- The where clause will filter the results. This query finds songs with a duration greater than 100 seconds
SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song
WHERE SongLength > 100;


-- JOIN combines tables together into one result
SELECT s.Title,
       a.ArtistName
  FROM Song s
       LEFT JOIN Artist a on s.ArtistId = a.id;


-- Create a new row in the Genre table
INSERT INTO Genre (Label) VALUES ('Techno');


-- Update existing data
select SongLength from Song where Id = 18;

-- The following is the output you get when you run the query above.
-- > 237

update Song
set SongLength = 515
where Id = 18;

-- Once you run the update statement, in order to make sure the value has changed, we run the select query again.
select SongLength from Song where Id = 18;
-- > 515


-- Deleteing data
delete from Song where Id = 18;


-- Be careful leaving off the WHERE clause like below. It will remove ALL ROWS from the table
delete from Song;


-- Query ALL entries in the Genre table
SELECT
    Id,
    Label
FROM Genre;


-- Query all entries in the Artist table, and order them by Artist name
SELECT
    Id,
    ArtistName,
    YearEstablished
FROM Artist ORDER BY Artist.ArtistName;


-- Query a list of all artists that have a Pop album
SELECT a.ArtistName
       
  FROM Album al
       LEFT JOIN Artist a on al.ArtistId = a.id
  WHERE al.GenreId = 4



-- Query a list of artists that have a Jazz or Rock Album
SELECT a.ArtistName
       
  FROM Album al
       LEFT JOIN Artist a on al.ArtistId = a.id
  WHERE al.GenreId = 2 OR al.GenreId = 4


-- Query albums with no songs
Select al.Title
FROM Album al
    LEFT JOIN Song on Song.AlbumId = al.Id
    WHERE Song.id IS NULL


-- Insert Artist
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('The Pharcyde', 1989);


-- Insert Album for the above artist
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Bizarre Ride II the Pharcyde', '11/24/1992', 3401, 'Delicious Vinyl', 28, 13);


-- Insert Songs for the above album
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Passin Me By', 303, '11/24/1992', 13, 28, 23);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Return of the B-Boy', 212, '11/24/1992', 13, 28, 23);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Ya Mama', 265, '11/24/1992', 13, 28, 23);


-- Query for song titles, album title, and artist name for the data that was entered above
Select al.Title, s.Title, a.ArtistName
FROM Song s LEFT JOIN Album al ON s.AlbumId = al.Id 
LEFT JOIN Artist a ON al.ArtistId = a.Id
WHERE al.ArtistId = 28


-- Query to select how many songs exist for each album
SELECT COUNT(Song.Id)
FROM Song
GROUP BY song.AlbumId


-- Query to select how many songs exist for each artist
SELECT COUNT(Song.Id)
FROM Song
GROUP BY Song.ArtistId


-- Query to select how many songs exist for each genre
SELECT COUNT(Song.Id)
FROM Song
GROUP BY Song.GenreId


-- Query to select Artists that have put out records on more than one record label.
SELECT a.ArtistName
FROM Artist a LEFT JOIN Album al ON a.Id = al.ArtistId
GROUP BY al.Label, a.ArtistName
HAVING COUNT(al.Label) > 1


-- Query to find the album with the longest duration, result should have album title and duration
SELECT al.Title, al.AlbumLength
FROM Album al
WHERE al.AlbumLength = (SELECT MAX(al.AlbumLength) FROM Album al)


-- Query to find the song with the longest duration, result should have song title and duration
SELECT s.Title, s.SongLength, al.Title
FROM Song s LEFT JOIN Album al ON s.AlbumId = al.Id
WHERE s.SongLength = (SELECT MAX(s.SongLength) FROM Song s)