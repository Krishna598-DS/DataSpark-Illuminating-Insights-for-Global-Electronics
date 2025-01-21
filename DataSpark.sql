use customer_sale_data;

-- Total Customers
SELECT COUNT(CustomerKey) AS Total_Customers
FROM customer_details;

-- Customers by Gender
SELECT Gender, COUNT(*) AS Total_Customers
FROM customer_details
GROUP BY Gender;

-- Customers by State
SELECT State, COUNT(*) AS Customer_Count
FROM customer_details
GROUP BY State
ORDER BY Customer_Count DESC;

-- Total Sales by Product
SELECT pd.ProductKey, pd.Product_Name, SUM(sd.Quantity) AS Total_Sales
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.ProductKey, pd.Product_Name
ORDER BY Total_Sales DESC;

-- Total Revenue by Product
SELECT pd.ProductKey, pd.Product_Name, SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.ProductKey, pd.Product_Name
ORDER BY Total_Revenue DESC;

-- Top-Selling Brand
SELECT pd.Brand, SUM(sd.Quantity) AS Total_Quantity_Sold
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.Brand
ORDER BY Total_Quantity_Sold DESC
LIMIT 1;

-- Total Sales by Store
SELECT sd.StoreKey, COUNT(DISTINCT sd.Order_Number) AS Total_Orders
FROM sales_details sd
GROUP BY sd.StoreKey
ORDER BY Total_Orders DESC;

-- Total Sales by Currency Code
SELECT sd.Currency_Code, SUM(sd.Quantity) AS Total_Sales
FROM sales_details sd
GROUP BY sd.Currency_Code
ORDER BY Total_Sales DESC;

-- Top-Spending Customers:
SELECT sd.CustomerKey, c.Name, SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Spending
FROM sales_details sd
JOIN customer_details c ON sd.CustomerKey = c.CustomerKey
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY sd.CustomerKey, c.Name
ORDER BY Total_Spending DESC
LIMIT 10;

-- Repeat Customers:
SELECT sd.CustomerKey, c.Name, COUNT(DISTINCT sd.Order_Number) AS Total_Orders
FROM sales_details sd
JOIN customer_details c ON sd.CustomerKey = c.CustomerKey
GROUP BY sd.CustomerKey, c.Name
HAVING Total_Orders > 1
ORDER BY Total_Orders DESC;

-- Customer Purchase Frequency:
SELECT sd.CustomerKey, c.Name, 
       COUNT(DISTINCT sd.Order_Date) AS Purchase_Frequency
FROM sales_details sd
JOIN customer_details c ON sd.CustomerKey = c.CustomerKey
GROUP BY sd.CustomerKey, c.Name
ORDER BY Purchase_Frequency DESC;

-- Best-Selling Products by Revenue:
SELECT pd.ProductKey, pd.Product_Name, 
       SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.ProductKey, pd.Product_Name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Slow-Moving Products:
SELECT pd.ProductKey, pd.Product_Name, 
       SUM(sd.Quantity) AS Total_Quantity_Sold
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.ProductKey, pd.Product_Name
HAVING Total_Quantity_Sold < 10
ORDER BY Total_Quantity_Sold ASC;

-- Product Categories with the Highest Revenue:
SELECT pd.Category, 
       SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY pd.Category
ORDER BY Total_Revenue DESC;

-- Monthly Sales Trend:
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Month, 
       SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Month;

-- Yearly Sales Growth:
SELECT YEAR(Order_Date) AS Year, 
       SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- Peak Sales Days:
SELECT Order_Date, 
       SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY Order_Date
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Top-Performing Stores:
SELECT sd.StoreKey, st.Country, st.State, 
       SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN store_details st ON sd.StoreKey = st.StoreKey
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY sd.StoreKey, st.Country, st.State
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Underperforming Stores:
SELECT sd.StoreKey, st.Country, st.State, 
       SUM(sd.Quantity * pd.Unit_Price_USD) AS Total_Revenue
FROM sales_details sd
JOIN store_details st ON sd.StoreKey = st.StoreKey
JOIN product_details pd ON sd.ProductKey = pd.ProductKey
GROUP BY sd.StoreKey, st.Country, st.State
HAVING Total_Revenue < 155000
ORDER BY Total_Revenue ASC;

-- Popular Product Bundles:
SELECT sd1.ProductKey AS Product1, sd2.ProductKey AS Product2, 
       COUNT(*) AS Bundle_Count
FROM sales_details sd1
JOIN sales_details sd2 ON sd1.Order_Number = sd2.Order_Number 
                       AND sd1.ProductKey < sd2.ProductKey
GROUP BY sd1.ProductKey, sd2.ProductKey
ORDER BY Bundle_Count DESC
LIMIT 10;

