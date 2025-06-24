create database HealthyFood_DB;
GO

USE HealthyFood_DB;
GO

-- Roles Table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50) -- Admin, Guest, Customer, Nutritionist, Seller, Shipper
);

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Fullname NVARCHAR(50),
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(50),
    Email VARCHAR(50) UNIQUE,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- CustomerProfiles Table
CREATE TABLE CustomerProfiles (
    CustomerID INT PRIMARY KEY,
    Phone VARCHAR(50) UNIQUE,
    Gender NVARCHAR(10),
    Height DECIMAL(5,2),
    Weight DECIMAL(5,2),
    BMI DECIMAL(5,2),
    ActivityLevel NVARCHAR(50),
    Goal NVARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    SellerID INT,
    CategoryID INT,
    ProductName NVARCHAR(50),
    Price INT,
    Description NVARCHAR(100),
	Ingredient NVARCHAR(255),
    Weight DECIMAL(5,2),
    Calories DECIMAL(5,2),
    Protein DECIMAL(5,2),
    Fat DECIMAL(5,2),
    Carbs DECIMAL(5,2),
    Tags NVARCHAR(100),
	ImageUrl VARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SellerID) REFERENCES Users(UserID)
);

CREATE TABLE Cart (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    
    CONSTRAINT FK_Cart_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    CONSTRAINT FK_Cart_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    CONSTRAINT UQ_Cart_User_Product UNIQUE (UserID, ProductID)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NULL,
    CustomerName NVARCHAR(50) NOT NULL,
    CustomerEmail VARCHAR(50) NOT NULL,
    CustomerPhone VARCHAR(50) NOT NULL,
    DeliveryAddress NVARCHAR(50) NOT NULL,
    OrderDate DATE,
    TotalPrice INT,
    DeliveryStatus NVARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- MealPlans Table
CREATE TABLE MealPlans (
    MealPlanID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    PlanDate DATE,
    Status NVARCHAR(50), -- Approved, Rejected
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- MealPlanDetails Table
CREATE TABLE MealPlanDetails (
    MealPlanID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (MealPlanID, ProductID),
    FOREIGN KEY (MealPlanID) REFERENCES MealPlans(MealPlanID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Shipping Table
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ShipperID INT,
    Status NVARCHAR(20), -- shipping, delivered
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ShipperID) REFERENCES Users(UserID)
);

-- Notifications Table
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Message NVARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE ConsulationRequests (
    RequestID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    RequestDate DATETIME NOT NULL DEFAULT GETDATE(),
    PreferredDate DATETIME NULL, -- Ngày và giờ mong muốn tư vấn (gộp lại)
    Status NVARCHAR(50) DEFAULT 'Pending',
    ResponseNote NVARCHAR(1000) NULL,
    FOREIGN KEY (CustomerID) REFERENCES CustomerProfiles(CustomerID)
);

INSERT INTO ConsulationRequests (
    CustomerID, PreferredDate, Status, ResponseNote
)
VALUES (
    3, 
    '2025-06-15 08:30:00', 
    'Accepted', 
    N' Thực đơn 1 ngày:
	- Sáng: 1 bát cháo yến mạch + 1 quả trứng luộc + 1 ly sữa đậu nành
	- Trưa: 100g ức gà + rau luộc + 1 chén cơm gạo lứt
	- Xế: 1 quả táo + 10 hạt hạnh nhân
	- Tối: Salad cá hồi + 1 củ khoai lang luộc'
);
INSERT INTO ConsulationRequests (
    CustomerID, PreferredDate, ResponseNote
)
VALUES (
    4, 
    '2025-06-13 08:30:00', 
    N' Thực đơn 1 ngày:
	- Sáng: 1 bát cháo yến mạch + 1 quả trứng luộc + 1 ly sữa đậu nành
	- Trưa: 100g ức gà + rau luộc + 1 chén cơm gạo lứt
	- Xế: 1 quả táo + 10 hạt hạnh nhân
	- Tối: Salad cá hồi + 1 củ khoai lang luộc'
);


select * from ConsulationRequests

-- Insert Roles
INSERT INTO Roles (RoleName) VALUES ('Admin');
INSERT INTO Roles (RoleName) VALUES ('Guest');
INSERT INTO Roles (RoleName) VALUES ('Customer');
INSERT INTO Roles (RoleName) VALUES ('Nutritionist');
INSERT INTO Roles (RoleName) VALUES ('Seller');
INSERT INTO Roles (RoleName) VALUES ('Shipper');

-- Insert Users
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Admin One', 'admin1', 'pass123', 'admin1@example.com', 1);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Guest One', 'guest1', 'pass123', 'guest1@example.com', 2);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Customer One', 'customer1', 'pass123', 'cust1@example.com', 3);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Customer Two', 'customer2', 'pass123', 'cust2@example.com', 3);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Customer Three', 'customer3', 'pass123', 'cust3@example.com', 3);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Nutritionist One', 'nutri1', 'pass123', 'nutri1@example.com', 4);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Seller One', 'seller1', 'pass123', 'seller1@example.com', 5);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Seller Two', 'seller2', 'pass123', 'seller2@example.com', 5);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Shipper One', 'shipper1', 'pass123', 'shipper1@example.com', 6);
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Shipper One', 'shipper2', 'pass123', 'shipper2@example.com', 6);

-- Insert CustomerProfiles
INSERT INTO CustomerProfiles (CustomerID, Phone, Gender, Height, Weight, BMI, ActivityLevel, Goal)
VALUES
	(3, '0901234567', N'Nam', 175.5, 70.0, 22.8, N'Trung bình', N'Tăng cơ'),
	(4, '0901234568', N'Nữ', 160.0, 55.0, 21.5, N'Thấp', N'Giảm cân'),
	(5, '0912345678', N'Nam', 180.0, 80.0, 24.7, N'Cao', N'Giữ dáng');


-- Insert Categories
INSERT INTO Categories (CategoryName) VALUES (N'Cuốn lành mạnh');
INSERT INTO Categories (CategoryName) VALUES (N'Ít tinh bột');
INSERT INTO Categories (CategoryName) VALUES (N'Thuần chay đặc biệt');


-- Insert Products
INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Ingredient, Weight, Calories, Protein, Fat, Carbs, Tags, ImageUrl)
VALUES
(N'Gỏi cuốn tôm tươi', 7, 1, 50000, N'Bánh cuốn tôm và rau thơm', N'vỏ bánh tortilla, tôm luộc, rau sống, bún tươi, húng quế, dưa leo', 150, 180, 12, 4, 25, N'hải sản, bún', 'img/FreshShrimpRolls.jpg'),
(N'Cuốn salad gà', 7, 1, 60000, N'Gà nướng cuốn rau xà lách', N'ức gà nướng, xà lách, cà rốt bào, dưa leo, vỏ bánh tortilla', 200, 250, 20, 5, 15, N'gà, vỏ tortilla', 'img/ChickenSaladWrap.jpeg'),
(N'Tô bún đậu hũ', 7, 2, 55000, N'Tô thuần chay với đậu hũ và bún gạo lứt', N'đậu hũ chiên, bún gạo lứt, rau sống, nước tương, đậu phộng rang', 250, 270, 14, 6, 30, N'đậu hũ, bún, hạt', 'img/TofuNoodleBowl.jpg'),
(N'Cuốn bò nướng', 7, 1, 70000, N'Bánh tráng cuốn bò nướng', N'thịt bò nướng, rau thơm, xà lách, bánh tráng, hành phi', 180, 290, 22, 7, 20, N'bò, bánh tráng', 'img/GrilledBeefRolls.png'),
(N'Salad bơ tươi', 7, 2, 50000, N'Salad với bơ tươi', N'bơ, xà lách, cà chua bi, hạt chia, dầu olive', 180, 210, 6, 10, 20, N'trái cây, hạt', 'img/AvocadoSalad.jpg'),
(N'Cuốn xoài rau củ', 7, 3, 52000, N'Cuốn với xoài và rau tươi', N'xoài chín, cà rốt, dưa leo, xà lách, vỏ bánh tortilla', 160, 200, 5, 3, 28, N'trái cây, vỏ tortilla', 'img/MangoVeggieWrap.jpg'),
(N'Tô trứng cuộn', 7, 2, 58000, N'Trứng cuộn dạng tô', N'trứng gà, cải bó xôi, nấm mèo, hành lá, nước tương', 200, 240, 18, 8, 18, N'trứng, rau củ, nấm', 'img/EggRollBowl.jpg'),
(N'Cuốn tôm cay', 7, 1, 62000, N'Tôm cay cuốn cùng rau xanh', N'tôm xào cay, xà lách, bún tươi, rau thơm, vỏ bánh tortilla', 190, 260, 19, 5, 22, N'hải sản, bún, vỏ tortilla', 'img/SpicyShrimpWrap.jpg'),
(N'Gỏi cuốn đậu hũ', 7, 3, 53000, N'Cuốn thuần chay với đậu hũ và bạc hà', N'đậu hũ chiên, bún, bạc hà, rau sống, bánh tráng', 150, 220, 10, 4, 26, N'đậu hũ, bún, bánh tráng', 'img/TofuSpringRolls.jpg'),
(N'Tô quinoa gà nướng', 7, 2, 65000, N'Tô gà nướng và hạt quinoa', N'hạt quinoa, ức gà nướng, rau cải mầm, sốt mè rang, ngô', 250, 300, 25, 7, 20, N'gà, hạt', 'img/ChickenQuinoaBowl.jpg'),
(N'Cuốn gà ngũ sắc', 8, 1, 68000, N'Ức gà hấp cuộn ớt chuông, cà rốt, dưa leo', N'gà hấp, ớt chuông, cà rốt, dưa leo, rau mùi, vỏ bánh tortilla', 170, 260, 23, 6, 18, N'gà, vỏ tortilla', 'img/RainbowVeggieChickenWrap.jpg'),
(N'Tô đậu que xào nấm', 8, 2, 54000, N'Đậu que non xào nấm rơm và mè rang', N'đậu que non, nấm rơm, mè rang, dầu gạo, hành boa rô', 200, 210, 9, 7, 12, N'nấm, đậu que', 'img/GreenBeansMushroom.jpg'),
(N'Salad trứng luộc cải xoăn', 8, 2, 56000, N'Trứng gà ta, cải xoăn và hạt óc chó', N'trứng gà ta, cải xoăn, hạt óc chó, cà chua bi, nước sốt chua ngọt', 190, 250, 13, 10, 9, N'trứng, hạt', 'img/EggKaleSalad.jpg'),
(N'Món cuộn thanh cua bơ xanh', 8, 1, 72000, N'Xà lách xoăn cuộn thanh cua, bơ sáp', N'thanh cua, bơ, rau xà lách, rau mầm, bánh tráng', 180, 240, 17, 8, 16, N'hải sản, bánh tráng', 'img/CrabStickAvocadoRolls.jpg'),
(N'Món cuộn tôm bưởi', 8, 1, 70000, N'Tôm luộc cuộn với tép bưởi và rau tía tô', N'tôm luộc, tép bưởi, rau tía tô, xà lách, bánh tráng', 160, 230, 19, 5, 20, N'hải sản, trái cây, bánh tráng', 'img/PomeloShrimpRolls.jpg'),
(N'Cuốn củ quả nướng', 8, 3, 54000, N'Cà rốt, củ dền, bí đỏ nướng cuốn cùng rau thơm', N'cà rốt, bí đỏ, củ dền, rau mùi, sốt mè rang, vỏ bánh tortilla', 170, 210, 6, 4, 28, N'vỏ tortilla', 'img/RootVeggieWrap.png'),
(N'Tô gà xé nấm đông cô', 8, 2, 60000, N'Ức gà luộc xé trộn cùng nấm đông cô hấp', N'gà luộc xé, nấm đông cô, hành lá, rau thơm, nước mắm chay', 220, 270, 24, 5, 10, N'gà, nấm', 'img/ChickenSeamedShiitake.jpg'),
(N'Salad cam hạt điều', 8, 3, 52000, N'Cam tươi trộn rau mầm, hạt điều rang', N'cam tươi, rau mầm, hạt điều rang, rau rocket, giấm táo', 180, 220, 7, 8, 22, N'trái cây, hạt', 'img/OrangeCashewSalad.png'),
(N'Món cuộn nấm kim châm rong biển', 8, 3, 55000, N'Nấm kim châm hấp cuộn rong biển và đậu hũ non', N'nấm kim châm, rong biển, đậu hũ non, cà rốt, xà lách', 160, 200, 9, 3, 26, N'nấm, rong biển, đậu hũ', 'img/EnokiSeaweedRolls.jpg'),
(N'Tô hạt sen và yến mạch', 8, 3, 56000, N'Hạt sen luộc, yến mạch ngâm và chuối tươi', N'hạt sen luộc, yến mạch ngâm, chuối chín, sữa hạnh nhân', 200, 240, 8, 5, 30, N'yến mạch', 'img/LotusOatmealBowl.png');

