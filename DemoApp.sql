Create database DemoApp
use DemoApp

CREATE TABLE Countries (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Area DECIMAL
	)
	TRUNCATE TABLE Countries

INSERT INTO Countries
VALUES
     ('India', 3287263.00),
    ('Italy', 301340.00),
	('United States', 9372610.00),
    ('Canada', 9984670.00),
    ('Germany', 357022.00);
	Select * from Countries

CREATE TABLE Cities (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL unique,
    Area DECIMAL,
	CountryId int FOREIGN KEY REFERENCES Countries(Id)
)
	Select * from Cities
	drop table Cities

	
INSERT INTO Cities 
VALUES
	 ('Rome', 1285.31, 5),
	('New Delhi', 1484.00, 4),
	('New York City', 789.43,1),
    ('Toronto', 630.20,2),
    ('Berlin', 891.85,3);  
	select * from Cities


CREATE TABLE People (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL,
    PhoneNumber NVARCHAR(20) not null,
    Email NVARCHAR(100) not null,
    Age datetime not null,
    Gender NVARCHAR(10) not null,
    HasCitizenship BIT not null,
	CityId int FOREIGN KEY REFERENCES Cities(Id)
)
drop table People
INSERT INTO People
VALUES
	('Priya', 'Patel', '9876543211', 'priya.patel@example.com', '1995-03-20', 'Female', 0, 5),
	('Marco', 'Rossi', '9876543212', 'marco.rossi@example.com', '1985-12-10', 'Male', 1, 4),
    ('John', 'Doe', '123456789', 'john.doe@example.com', '1994-05-15', 'Male', 1, 1),
    ('Jane', 'Smith', '987654321', 'jane.smith@example.com', '1999-10-20', 'Female', 0, 2),
    ('Michael', 'Johnson', '555123456', 'michael.johnson@example.com', '1979-02-28', 'Male', 1, 3);
		Select * From People


--1
Select People.Name,People.Surname, Cities.Name as City, Countries.Name as Country
From People
Inner Join Cities on People.CityId=Cities.Id
Inner join Countries on Cities.CountryId=Countries.Id

--2
Select * from Countries
Order by Area

Select * from Cities
Order by Name

--3
Select * from Countries
Where Area>20000

Select Max(Area) as Area from Countries
Where Countries.Name Like 'I%'

--4
Select Name from Countries
Union 
Select Name from Cities

--5
Select Count(People.Id) as 'People Count', Cities.Name
From People
Inner join Cities On Cities.Id=People.CityId
Group By Cities.Name

Select Count(People.Id) as 'People Count', Cities.Name
From People
Inner join Cities On Cities.Id=People.CityId
Where (People.Id)>50000
Group By Cities.Name