-- Check Dataset
SELECT *
FROM cleaned_sales_data
LIMIT 5;

-- Table Structure
DESCRIBE cleaned_sales_data;

-- KPI Analysis

-- Total Sales
SELECT ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data;

-- Total Profit
SELECT ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM cleaned_sales_data;

-- Total Customers
SELECT COUNT(DISTINCT customer_name) AS Total_Customers
FROM cleaned_sales_data;

-- Total Quantity Sold
SELECT SUM(quantity) AS Total_Quantity_Sold
FROM cleaned_sales_data;

-- Region Wise Sales
SELECT region,
       ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data
GROUP BY region
ORDER BY Total_Sales DESC;

-- Market Wise Sales
SELECT market,
       ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data
GROUP BY market
ORDER BY Total_Sales DESC;

-- Category Wise Sales
SELECT category,
       ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data
GROUP BY category
ORDER BY Total_Sales DESC;

-- Sub Category Wise Sales
SELECT sub_category,
       ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data
GROUP BY sub_category
ORDER BY Total_Sales DESC;

-- Top 10 Products by Sales

SELECT product_name,
       ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Top 10 Products by Profit

SELECT product_name,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY product_name
ORDER BY Total_Profit DESC
LIMIT 10;

-- Bottom 10 Products by Profit

SELECT product_name,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY product_name
ORDER BY Total_Profit ASC
LIMIT 10;

-- Category Wise Profit

SELECT category,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY category
ORDER BY Total_Profit DESC;

-- Sub Category Wise Profit

SELECT sub_category,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY sub_category
ORDER BY Total_Profit DESC;

-- Top Products by Quantity Sold

SELECT product_name,
       SUM(quantity) AS Total_Quantity
FROM cleaned_sales_data
GROUP BY product_name
ORDER BY Total_Quantity DESC
LIMIT 10;
-- Average Discount by Category

SELECT category,
       ROUND(AVG(discount),2) AS Avg_Discount
FROM cleaned_sales_data
GROUP BY category
ORDER BY Avg_Discount DESC;

-- Top 10 Customers by Sales

SELECT customer_name,
       ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data
GROUP BY customer_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Top 10 Customers by Profit

SELECT customer_name,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY customer_name
ORDER BY Total_Profit DESC
LIMIT 10;

-- Customer Segment Performance

SELECT segment,
       COUNT(DISTINCT customer_name) AS Customers,
       ROUND(SUM(sales),2) AS Total_Sales,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY segment
ORDER BY Total_Sales DESC;

-- Market Wise Customer Count

SELECT market,
       COUNT(DISTINCT customer_name) AS Total_Customers
FROM cleaned_sales_data
GROUP BY market
ORDER BY Total_Customers DESC;

-- Region Wise Customer Count

SELECT region,
       COUNT(DISTINCT customer_name) AS Total_Customers
FROM cleaned_sales_data
GROUP BY region
ORDER BY Total_Customers DESC;

-- Average Sales per Customer

SELECT customer_name,
       ROUND(AVG(sales),2) AS Avg_Sales
FROM cleaned_sales_data
GROUP BY customer_name
ORDER BY Avg_Sales DESC
LIMIT 10;

-- Customers with Highest Orders

SELECT customer_name,
       COUNT(order_id) AS Total_Orders
FROM cleaned_sales_data
GROUP BY customer_name
ORDER BY Total_Orders DESC
LIMIT 10;

SELECT category,
       ROUND(SUM(sales),2) AS Total_Sales,
       ROUND(SUM(profit),2) AS Total_Profit,
       ROUND((SUM(profit)/SUM(sales))*100,2) AS Profit_Margin_Percent
FROM cleaned_sales_data
GROUP BY category
ORDER BY Profit_Margin_Percent DESC;

SELECT product_name,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY Total_Profit;

SELECT product_name,
       ROUND(SUM(sales),2) AS Total_Sales,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY product_name
HAVING SUM(sales) > 10000
ORDER BY Total_Profit ASC;

SELECT category,
       product_name,
       Total_Sales
FROM (
    SELECT category,
           product_name,
           ROUND(SUM(sales),2) AS Total_Sales,
           DENSE_RANK() OVER(
               PARTITION BY category
               ORDER BY SUM(sales) DESC
           ) AS rnk
    FROM cleaned_sales_data
    GROUP BY category, product_name
) t
WHERE rnk <= 5;

SELECT region,
       customer_name,
       Total_Sales
FROM (
    SELECT region,
           customer_name,
           ROUND(SUM(sales),2) AS Total_Sales,
           ROW_NUMBER() OVER(
               PARTITION BY region
               ORDER BY SUM(sales) DESC
           ) AS rn
    FROM cleaned_sales_data
    GROUP BY region, customer_name
) t
WHERE rn = 1;

SELECT order_date,
       sales,
       SUM(sales) OVER(
           ORDER BY order_date
       ) AS Running_Total_Sales
FROM cleaned_sales_data;

SELECT year,
       ROUND(SUM(sales),2) AS Total_Sales,
       ROUND(SUM(profit),2) AS Total_Profit
FROM cleaned_sales_data
GROUP BY year
ORDER BY year;

SELECT ship_mode,
       ROUND(AVG(shipping_days),2) AS Avg_Shipping_Days
FROM cleaned_sales_data
GROUP BY ship_mode
ORDER BY Avg_Shipping_Days;

SELECT order_priority,
       COUNT(*) AS Total_Orders,
       ROUND(SUM(sales),2) AS Total_Sales
FROM cleaned_sales_data
GROUP BY order_priority
ORDER BY Total_Sales DESC;

