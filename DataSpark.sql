USE dataspark;

SELECT * FROM customer_details;
SELECT * FROM sales_details;
SELECT * FROM product_details;
SELECT * FROM store_details;

-- Demographic Distribution of Customers by Gender and Age
SELECT 
    Gender, 
    FLOOR(DATEDIFF(CURDATE(), Birthday) / 365) AS AgeGroup, 
    COUNT(CustomerKey) AS CustomerCount
FROM customer_details
GROUP BY Gender, AgeGroup
ORDER BY CustomerCount DESC;

-- Top 10 Customers by Total Purchases
SELECT 
    sd.CustomerKey, 
    cd.Name, 
    SUM(sd.Quantity * pd.Unit_Price_USD) AS TotalPurchase
FROM sales_details sd
JOIN customer_details cd ON sd.CustomerKey = cd.CustomerKey
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY sd.CustomerKey, cd.Name
ORDER BY TotalPurchase DESC
LIMIT 10;

--  Top 10 Best-Selling Products
SELECT 
    pd.ProductKey, 
    pd.Product_Name, 
    SUM(sd.Quantity) AS TotalQuantitySold
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.ProductKey, pd.Product_Name
ORDER BY TotalQuantitySold DESC
LIMIT 10;

-- Profit Margins by Product
SELECT 
    pd.ProductKey, 
    pd.Product_Name, 
    pd.Unit_Cost_USD, 
    pd.Unit_Price_USD, 
    ROUND((pd.Unit_Price_USD - pd.Unit_Cost_USD) / pd.Unit_Cost_USD * 100, 2) AS ProfitMargin
FROM product_details pd
ORDER BY ProfitMargin DESC;

-- Total Sales and Monthly Trends
SELECT 
    DATE_FORMAT(sd.`Order_Date`, '%Y-%m') AS Month, 
    SUM(sd.Quantity * pd.Unit_Price_USD) AS TotalSales
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY Month
ORDER BY Month;

-- Average Order Value and Order Frequency
SELECT 
    sd.CustomerKey, 
    COUNT(DISTINCT sd.`Order_Number`) AS TotalOrders,
    ROUND(SUM(sd.Quantity * pd.Unit_Price_USD) / COUNT(DISTINCT sd.`Order_Number`), 2) AS AvgOrderValue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY sd.CustomerKey
ORDER BY AvgOrderValue DESC
LIMIT 10;

-- Top 5 Performing Stores by Sales
SELECT 
    st.StoreKey, 
    st.Country, 
    st.State, 
    SUM(sd.Quantity * pd.Unit_Price_USD) AS TotalSales
FROM sales_details sd
JOIN store_details st ON sd.StoreKey = st.StoreKey
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY st.StoreKey, st.Country, st.State
ORDER BY TotalSales DESC
LIMIT 5;

-- Sales Efficiency by Store (Sales per Square Meter)
SELECT 
    st.StoreKey, 
    st.Country, 
    st.State, 
    st.`Square_Meters`, 
    ROUND(SUM(sd.Quantity * pd.Unit_Price_USD) / st.`Square_Meters`, 2) AS SalesPerSquareMeter
FROM sales_details sd
JOIN store_details st ON sd.StoreKey = st.StoreKey
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY st.StoreKey, st.Country, st.State, st.`Square_Meters`
ORDER BY SalesPerSquareMeter DESC
LIMIT 10;

-- Sales by Region (Country and State)
SELECT 
    st.Country, 
    st.State, 
    SUM(sd.Quantity * pd.Unit_Price_USD) AS TotalSales
FROM sales_details sd
JOIN store_details st ON sd.StoreKey = st.StoreKey
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY st.Country, st.State
ORDER BY TotalSales DESC;

-- Total Sales by Product
SELECT 
    pd.Product_Name, 
    SUM(sd.Quantity * pd.Unit_Price_USD) AS TotalSales
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.Product_Name
ORDER BY TotalSales DESC
LIMIT 10;
