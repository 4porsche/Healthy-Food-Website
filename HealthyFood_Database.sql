CREATE DATABASE HealthyFoodDB;
GO

USE HealthyFoodDB;
GO

-- Roles Table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50) -- Admin, Guest, Customer, Nutritionist, Seller, Shipper
);

-- Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Fullname VARCHAR(50),
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
    Gender VARCHAR(10),
    Height DECIMAL(5,2),
    Weight DECIMAL(5,2),
    BMI DECIMAL(5,2),
    ActivityLevel VARCHAR(50),
    Goal VARCHAR(50),
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
    Weight DECIMAL(5,2),
    Calories DECIMAL(5,2),
    Protein DECIMAL(5,2),
    Fat DECIMAL(5,2),
    Carbs DECIMAL(5,2),
    Tags NVARCHAR(100),
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
    CustomerName VARCHAR(50) NOT NULL,
    CustomerEmail VARCHAR(50) NOT NULL,
    CustomerPhone VARCHAR(50) NOT NULL,
    DeliveryAddress VARCHAR(50) NOT NULL,
    OrderDate DATE,
    TotalPrice INT,
    DeliveryStatus VARCHAR(20),
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
    Status VARCHAR(50), -- Approved, Rejected
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
    Status VARCHAR(20), -- shipping, delivered
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ShipperID) REFERENCES Users(UserID)
);

-- Notifications Table
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Message VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

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
INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES ('Shipper One', 'shipper1', 'pass123', 'shipper1@example.com', 6);

-- Insert CustomerProfiles
INSERT INTO CustomerProfiles (CustomerID, Phone, Gender, Height, Weight, BMI, ActivityLevel, Goal)
VALUES (3, '0901234567', 'Male', 175.5, 70.0, 22.8, 'Moderate', 'Gain muscle');
INSERT INTO CustomerProfiles (CustomerID, Phone, Gender, Height, Weight, BMI, ActivityLevel, Goal)
VALUES (4, '0901234568', 'Female', 160.0, 55.0, 21.5, 'Low', 'Lose weight');
INSERT INTO CustomerProfiles (CustomerID, Phone, Gender, Height, Weight, BMI, ActivityLevel, Goal)
VALUES (5, '0912345678', 'Male', 180.0, 80.0, 24.7, 'High', 'Maintain weight');

-- Insert Categories
INSERT INTO Categories (CategoryName) VALUES (N'Healthy Rolls');
INSERT INTO Categories (CategoryName) VALUES (N'Low-Carb Meals');
INSERT INTO Categories (CategoryName) VALUES (N'Vegan Specials');

-- Insert Products
INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Fresh Spring Rolls', 7, 1, 50000, N'Rice paper rolls with shrimp and herbs', 150, 180, 12, 4, 25, N'light,shrimp');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Chicken Salad Wrap', 7, 1, 60000, N'Grilled chicken in lettuce wrap', 200, 250, 20, 5, 15, N'low-carb,chicken');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Tofu Noodle Bowl', 7, 2, 55000, N'Vegan bowl with tofu and noodles', 250, 270, 14, 6, 30, N'vegan,tofu');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Grilled Beef Rolls', 7, 1, 70000, N'Rice paper rolls with grilled beef', 180, 290, 22, 7, 20, N'beef,protein');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Avocado Salad', 7, 2, 50000, N'Salad with fresh avocado', 180, 210, 6, 10, 20, N'vegan,avocado');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Mango Veggie Wrap', 7, 3, 52000, N'Wrap with mango and fresh vegetables', 160, 200, 5, 3, 28, N'vegan,fruit');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Egg Roll Bowl', 7, 1, 58000, N'Deconstructed egg rolls in a bowl', 200, 240, 18, 8, 18, N'egg,balanced');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Spicy Shrimp Wrap', 7, 1, 62000, N'Spicy shrimp with greens in wrap', 190, 260, 19, 5, 22, N'shrimp,spicy');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Tofu Spring Rolls', 7, 3, 53000, N'Vegan rolls with tofu and mint', 150, 220, 10, 4, 26, N'vegan,tofu');

INSERT INTO Products (ProductName, SellerID, CategoryID, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags)
VALUES (N'Chicken Quinoa Bowl', 7, 2, 65000, N'Bowl with grilled chicken and quinoa', 250, 300, 25, 7, 20, N'chicken,healthy');

ALTER TABLE Products
ADD Image NVARCHAR(100);

UPDATE Products
SET Image = REPLACE(ProductName, ' ', '') + '.jpg';