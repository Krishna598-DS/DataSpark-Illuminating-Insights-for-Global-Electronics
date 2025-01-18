use customer_sale_data;

show tables;

DESCRIBE customer_details;

SELECT COUNT(CustomerKey) AS Total_Customers
FROM customer_details;

SELECT Gender, COUNT(*) AS Total_Customers
FROM customer_details
GROUP BY Gender;

SELECT State, COUNT(*) AS Customer_Count
FROM customer_details
GROUP BY State
ORDER BY Customer_Count DESC;

SELECT City, COUNT(*) AS Customer_Count
FROM customer_details
GROUP BY City
ORDER BY Customer_Count DESC;

SELECT Continent, COUNT(*) AS Customer_Count
FROM customer_details
GROUP BY Continent
ORDER BY Customer_Count DESC;

SELECT FLOOR(DATEDIFF(CURDATE(), Birthday) / 365) AS Age, COUNT(*) AS Customer_Count
FROM customer_details
GROUP BY Age
ORDER BY Age;

DESCRIBE exchange_details;

SELECT `Currency_code`, `Exchange`, `Date`
FROM exchange_details
WHERE `Currency_code` = 'USD'  -- You can replace 'USD' with any currency code
ORDER BY `Date` DESC
LIMIT 1;

SELECT `Currency_code`, AVG(`Exchange`) AS Avg_Exchange_Rate
FROM exchange_details
WHERE `Currency_code` = 'EUR'  -- You can replace 'EUR' with any currency code
GROUP BY `Currency_code`;

SELECT `Currency_code`, MAX(`Exchange`) AS Highest_Exchange_Rate
FROM exchange_details
WHERE `Currency_code` = 'INR'  -- You can replace 'INR' with any currency code
GROUP BY `Currency_code`;

SELECT `Currency_code`, MIN(`Exchange`) AS Lowest_Exchange_Rate
FROM exchange_details
WHERE `Currency_code` = 'GBP'  -- You can replace 'GBP' with any currency code
GROUP BY `Currency_code`;

SELECT `Date`, `Currency_code`, `Exchange`
FROM exchange_details
WHERE `Currency_code` = 'JPY'  -- You can replace 'JPY' with any currency code
ORDER BY `Date` DESC;


SELECT * from product_details;

SELECT COUNT(ProductKey) AS Total_Products
FROM product_details;

SELECT pd.ProductKey, pd.Product_Name, SUM(sd.Quantity) AS Total_Sales
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.ProductKey, pd.Product_Name
ORDER BY Total_Sales DESC;

SELECT pd.ProductKey, pd.Product_Name, SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.ProductKey, pd.Product_Name
ORDER BY Total_Revenue DESC;

SELECT pd.Category, AVG(pd.Unit_Price_USD) AS Avg_Unit_Price
FROM product_details pd
GROUP BY pd.Category
ORDER BY Avg_Unit_Price DESC;

SELECT ProductKey, Product_Name, Unit_Price_USD
FROM product_details
ORDER BY Unit_Price_USD DESC
LIMIT 1;

SELECT pd.Brand, SUM(sd.Quantity) AS Total_Quantity_Sold
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.Brand
ORDER BY Total_Quantity_Sold DESC
LIMIT 1;

SELECT pd.Category, COUNT(*) AS Product_Count
FROM product_details pd
GROUP BY pd.Category
ORDER BY Product_Count DESC;

SELECT pd.Subcategory, COUNT(*) AS Product_Count
FROM product_details pd
GROUP BY pd.Subcategory
ORDER BY Product_Count DESC;

SELECT * from sales_details;

SELECT COUNT(DISTINCT `Order_Number`) AS Total_Orders
FROM sales_details;


SELECT sd.CustomerKey, c.Name, SUM(sd.Quantity) AS Total_Sales
FROM sales_details sd
JOIN customer_details c ON sd.CustomerKey = c.CustomerKey
GROUP BY sd.CustomerKey, c.Name
ORDER BY Total_Sales DESC;

SELECT sd.ProductKey, SUM(sd.Quantity) AS Total_Sales
FROM sales_details sd
GROUP BY sd.ProductKey
ORDER BY Total_Sales DESC;

SELECT sd.StoreKey, COUNT(DISTINCT sd.`Order_Number`) AS Total_Orders
FROM sales_details sd
GROUP BY sd.StoreKey
ORDER BY Total_Orders DESC;

SELECT sd.CustomerKey, c.Name, AVG(sd.Quantity) AS Avg_Order_Quantity
FROM sales_details sd
JOIN customer_details c ON sd.CustomerKey = c.CustomerKey
GROUP BY sd.CustomerKey, c.Name
ORDER BY Avg_Order_Quantity DESC;

SELECT sd.`Currency_Code`, SUM(sd.Quantity) AS Total_Sales
FROM sales_details sd
GROUP BY sd.`Currency_Code`
ORDER BY Total_Sales DESC;

SELECT MONTH(Order_Date) AS Month, SUM(Quantity) AS Total_Sales
FROM sales_details
GROUP BY MONTH(Order_Date)
ORDER BY Month;

SELECT YEAR(Order_Date) AS Year, SUM(Quantity) AS Total_Sales
FROM sales_details
GROUP BY YEAR(Order_Date)
ORDER BY Year;

SELECT * from store_details;

SELECT Country, COUNT(*) AS Store_Count
FROM store_details
GROUP BY Country
ORDER BY Store_Count DESC;

SELECT State, COUNT(*) AS Store_Count
FROM store_details
WHERE Country = 'USA' -- Replace 'India' with the desired country
GROUP BY State
ORDER BY Store_Count DESC;

SELECT Country, 
       SUM(Square_Meters) AS Total_Square_Meters, 
       AVG(Square_Meters) AS Average_Square_Meters
FROM store_details
GROUP BY Country
ORDER BY Total_Square_Meters DESC;

SELECT Country, MIN(Open_Date) AS Oldest_Store_Open_Date
FROM store_details
GROUP BY Country
ORDER BY Oldest_Store_Open_Date ASC;

SELECT State, SUM(Square_Meters) AS Total_Square_Meters
FROM store_details
GROUP BY State
ORDER BY Total_Square_Meters DESC;

SELECT *
FROM store_details
WHERE Square_Meters > 1000 -- Replace with your desired threshold
ORDER BY Square_Meters DESC;

SELECT YEAR(Open_Date) AS Open_Year, COUNT(*) AS Store_Count
FROM store_details
GROUP BY YEAR(Open_Date)
ORDER BY Open_Year ASC;

SELECT *
FROM store_details
ORDER BY Square_Meters DESC
LIMIT 5;

SELECT *
FROM store_details
WHERE YEAR(Open_Date) = 2022; -- Replace with the desired year



