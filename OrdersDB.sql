Create Database OrdersDB
Use OrdersDB

CREATE TABLE Sellers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) not null
	)

	INSERT INTO Sellers
VALUES
	('Ley', 'Quli', 'Ləndaland'),
    ('Rəşad', 'Əliyev', 'Bakı'),
    ('Aynur', 'Həsənova', 'Gəncə'),
    ('Kamran', 'İsmayılov', 'Sumqayıt'),
    ('Leyla', 'Quliyeva', 'Lənkəran'),
    ('Fuad', 'Rzayev', 'Şəki'),
    ('Zaur', 'Nəsirov', 'Bakı'),
    ('Səkinə', 'Abdullayeva', 'Gəncə'),
    ('Elvin', 'Məmmədov', 'Sumqayıt');

CREATE TABLE Customers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) not null
	)

INSERT INTO Customers
VALUES
    ('Murad', 'Hüseynov', 'Bakı'),
    ('Nigar', 'Məmmədova', 'Gəncə'),
    ('Orxan', 'Qurbanov', 'Sumqayıt'),
    ('Gülşən', 'Əliyeva', 'Lənkəran'),
    ('İlqar', 'Əkbərov', 'Şəki'),
    ('Aysel', 'İsmayılova', 'Bakı'),
    ('Elnur', 'Quliyev', 'Gəncə'),
    ('Fatimə', 'Rüstəmova', 'Sumqayıt');


CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
	OrderDate datetime not null,
	Amount int NOT NULL,
	State bit not null,
	CustomerId int Foreign Key References Customers(Id),
	SellerId int Foreign Key References Sellers(Id)
)
INSERT INTO Orders
VALUES
    ('2024-01-05', 1200, 1, 1, 1),
    ('2024-01-10', 800, 0, 2, 2),
    ('2024-02-01', 1500, 1, 3, 3),
    ('2024-02-15', 500, 1, 4, 4),
    ('2024-03-01', 1000, 0, 5, 5),
    ('2024-03-05', 2000, 1, 1, 2),
    ('2024-03-10', 700, 1, 2, 3),
    ('2024-03-15', 900, 1, 3, 4),
    ('2024-04-01', 1100, 0, 4, 5),
    ('2024-04-10', 300, 1, 5, 1),
    ('2024-05-05', 1800, 1, 6, 6),
    ('2024-05-15', 2200, 1, 7, 7),
    ('2024-06-01', 2500, 1, 8, 8),
    ('2024-06-05', 600, 1, 1, 3),
    ('2024-06-10', 400, 0, 2, 4),
    ('2024-06-15', 1300, 1, 3, 5),
    ('2024-07-01', 1700, 1, 4, 6),
    ('2024-07-05', 900, 1, 5, 7),
    ('2024-07-10', 800, 0, 6, 8),
    ('2024-07-15', 1100, 1, 7, 1),
    ('2024-07-20', 2100, 1, 8, 2),
    ('2024-08-01', 1400, 1, 1, 3),
    ('2024-08-05', 1900, 1, 2, 4),
    ('2024-08-10', 1600, 0, 3, 5),
    ('2024-08-15', 1300, 1, 4, 6);

--a
Select Customers.Name as Name, Customers.Surname as Surname, Sum(Orders.Amount) as Total
From Orders
Inner join Customers on Customers.Id=Orders.CustomerId
Group by Customers.Name, Customers.Surname
Having SUM(Orders.Amount)>1000

--b
Select count(Customers.Name)
from Customers
inner join sellers on Customers.City=Sellers.City 

--c
Select Orders.Id As OrderId, Orders.State as IsCompleted,Orders.OrderDate
from Orders
Where Orders.State=1 and Orders.OrderDate Between '2024-01-04' AND GETDATE()

--d
Select Sellers.Name, Sellers.Surname ,Count(Orders.Id) as OrderCount
from sellers
inner join Orders on Orders.SellerId=Sellers.Id
where Orders.State=1
Group by Sellers.Name, Sellers.Surname
Having Count(Orders.State)>10

--e
Select Customers.Name, Customers.Surname, Count(Orders.Id) as OrderCount
from Orders
inner join Customers on Customers.Id=Orders.CustomerId
Group by Customers.Name, Customers.Surname
Order by OrderCount desc

--f
Select Orders.Id,Sellers.Name as SellerName ,Sellers.Surname as SellerSurname, Orders.State, Orders.OrderDate
from Sellers
inner join Orders on Orders.SellerId=Sellers.Id
where Orders.State=0
Order by Orders.OrderDate

--g
Select * From Orders
where Orders.State=1 and Orders.OrderDate >= DATEADD(MONTH, -1, GETDATE())
