Create database MoviesDb
use MoviesDb

CREATE TABLE Genres (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

INSERT INTO Genres (Name)
VALUES
    ('Drama'),
    ('Action'),
    ('Science Fiction'),
    ('Romance'),
    ('Thriller'),
    ('Adventure'),
    ('Crime'),
    ('Fantasy');

CREATE TABLE Actors (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL
);
INSERT INTO Actors
VALUES
    ('Leonardo', 'DiCaprio'),
    ('Kate', 'Winslet'),
    ('Keanu', 'Reeves'),
    ('Morgan', 'Freeman'),
    ('Christian', 'Bale'),
    ('Tom', 'Hanks'),
    ('Matthew', 'McConaughey'),
    ('Marlon', 'Brando');

CREATE TABLE Movies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    ReleaseDate DATETIME NOT NULL,
    IMDB DECIMAL(3, 1) NOT NULL,
	GenreId int Foreign Key References Genres(Id),
);
INSERT INTO Movies
VALUES
	('Future Movie', '2025-07-01', 0.0, 5),
    ('İnception', '2010-07-16', 8.8, 3),
    ('Titanik', '1997-12-19', 7.8, 4),
    ('Matrix', '1999-03-31', 8.7, 3),
    ('Şawshank Redemption', '1994-09-22', 9.3, 1),
    ('The Dark Knight', '2008-07-18', 9.0, 2),
    ('Forrest Gump', '1994-07-06', 8.8, 1),
    ('Interstellar', '2014-11-07', 8.6, 3),
    ('The Godfather', '1972-03-24', 9.2, 7);

CREATE TABLE ActorMovies (
    Id INT PRIMARY KEY IDENTITY(1,1),
	MovieId int Foreign Key References Movies(Id),
	ActorId int Foreign Key References Actors(Id),
);
INSERT INTO ActorMovies 
VALUES
    (1, 1),
    (2, 1), 
    (2, 2), 
    (3, 3), 
    (4, 4),
    (5, 5), 
    (6, 6), 
    (7, 7), 
    (8, 8); 

--a
SELECT Actors.Name, Actors.Surname,  COUNT(ActorMovies.MovieId) AS RoleCount
FROM  Actors
JOIN  ActorMovies ON Actors.Id = ActorMovies.ActorId
GROUP BY 
    Actors.Name, Actors.Surname
ORDER BY 
    RoleCount DESC;

--b
SELECT Genres.Name AS Genre,  COUNT(Movies.Id) AS MovieCount
FROM  Genres
JOIN Movies ON Genres.Id = Movies.GenreId
GROUP BY Genres.Name;

--c
SELECT Name, ReleaseDate
FROM Movies
WHERE ReleaseDate > GETDATE()

--d
SELECT AVG(IMDB) AS AverageIMDB
FROM Movies
WHERE ReleaseDate >= DATEADD(YEAR, -5, GETDATE());

--e
SELECT Actors.Name,Actors.Surname, 
    COUNT(ActorMovies.MovieId) AS MovieCount
FROM Actors JOIN ActorMovies ON Actors.Id = ActorMovies.ActorId
GROUP BY Actors.Name, Actors.Surname
HAVING COUNT(ActorMovies.MovieId) > 1

