__question1
-- For databases without STRING_SPLIT function
CREATE TABLE OrderProducts_1NF AS
SELECT 
    OrderID,
    CustomerName,
    'Laptop' AS Product
FROM 
    ProductDetail
WHERE 
    Products LIKE '%Laptop%'
UNION ALL
SELECT 
    OrderID,
    CustomerName,
    'Mouse'
FROM 
    ProductDetail
WHERE 
    Products LIKE '%Mouse%'
UNION ALL
SELECT 
    OrderID,
    CustomerName,
    'Tablet'
FROM 
    ProductDetail
WHERE 
    Products LIKE '%Tablet%'
UNION ALL
SELECT 
    OrderID,
    CustomerName,
    'Keyboard'
FROM 
    ProductDetail
WHERE 
    Products LIKE '%Keyboard%'
UNION ALL
SELECT 
    OrderID,
    CustomerName,
    'Phone'
FROM 
    ProductDetail
WHERE 
    Products LIKE '%Phone%';

__question2
BEGIN TRANSACTION;

-- Create normalized tables
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Populate OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

COMMIT;