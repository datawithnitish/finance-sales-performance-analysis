-- =====================================================================
-- FINANCE ANALYSIS
-- =====================================================================
-- Sections:
--   1. Sales Performance      (Q1 - Q6)
--   2. Profitability Analysis (Q7 - Q11)
--   3. Customer Analysis      (Q12 - Q13)
--   4. Budget vs Actual       (Q14 - Q15)
-- =====================================================================

CREATE DATABASE IF NOT EXISTS finance;
USE finance;


-- =====================================================================
-- SECTION 1: SALES PERFORMANCE
-- =====================================================================

-- 1. How many total sales transactions/orders are there?
SELECT 
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
    sales;

-- Insight: The dataset contains 50k sales transactions.


-- 2. What is the total revenue generated from all sales?
SELECT 
    ROUND(SUM(Net_Revenue), 2) AS Total_Revenue
FROM
    sales;

-- Insight: Total revenue generated is approximately 3355172364.39


-- 3. What is the monthly revenue trend?
SELECT 
    MONTH(Order_Date) AS Month,
    MONTHNAME(Order_Date) AS Month_Name,
    ROUND(SUM(Net_Revenue), 2) AS Total_Revenue
FROM
    sales
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY Month;

-- Insight: Revenue was highest in January and lowest in February.
-- After February, monthly revenue remained relatively stable with moderate fluctuations.


-- 4. Which region generates the highest revenue?
SELECT 
    Region, 
    ROUND(SUM(Net_Revenue), 2) AS Total_Revenue
FROM
    sales
GROUP BY Region
ORDER BY Total_Revenue DESC
LIMIT 1;

-- Insight: Central region has the highest revenue, approximately 735671057.76


-- 5. Which sales channel generates the highest revenue?
SELECT 
    Channel, 
    ROUND(SUM(Net_Revenue), 2) AS Total_Revenue
FROM
    sales
GROUP BY Channel
ORDER BY Total_Revenue DESC
LIMIT 1;

-- Insight: Online channel has the highest revenue, approximately 1181017464.29


-- 6. Which product category generates the highest revenue?
SELECT 
    Category, 
    ROUND(SUM(Net_Revenue), 2) AS Total_Revenue
FROM
    sales
GROUP BY Category
ORDER BY Total_Revenue DESC
LIMIT 1;

-- Insight: Services category has the highest revenue, approximately 1260164167.08


-- =====================================================================
-- SECTION 2: PROFITABILITY ANALYSIS
-- =====================================================================

-- 7. What is the total gross profit generated?
SELECT 
    ROUND(SUM(Gross_Profit), 2) AS Total_Profit
FROM
    sales;

-- Insight: Total profit generated is approximately 913898256.7


-- 8. Which region generates the highest gross profit?
SELECT 
    Region, 
    ROUND(SUM(Gross_Profit), 2) AS Total_Profit
FROM
    sales
GROUP BY Region
ORDER BY Total_Profit DESC
LIMIT 1;

-- Insight: Central region generated the highest gross profit, approximately 198813900.87


-- 9. What are the top 5 products by gross profit?
SELECT 
    Product_ID, 
    ROUND(SUM(Gross_Profit), 2) AS Total_Profit
FROM
    sales
GROUP BY Product_ID
ORDER BY Total_Profit DESC
LIMIT 5;

-- Insight: P025 has the highest gross profit and P016 has the lowest among the top 5 products.


-- 10. Which products generate high revenue but have a low profit margin?
-- Assumptions:
--   High revenue      = above the average product revenue
--   Low profit margin = below 30%
SELECT 
    Product_ID,
    ROUND(SUM(Net_Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Gross_Profit), 2) AS Total_Gross_Profit,
    ROUND((SUM(Gross_Profit) / SUM(Net_Revenue)) * 100, 2) AS Profit_Margin_pct
FROM
    sales
GROUP BY Product_ID
HAVING SUM(Net_Revenue) > (
        SELECT AVG(Product_Revenue)
        FROM (
            SELECT 
                Product_ID, 
                SUM(Net_Revenue) AS Product_Revenue
            FROM
                sales
            GROUP BY Product_ID
        ) AS revenue_data
    )
    AND (SUM(Gross_Profit) / SUM(Net_Revenue)) * 100 < 30
ORDER BY Product_ID DESC;


-- 11. Which sales channel generates the highest gross profit?
SELECT 
    Channel, 
    ROUND(SUM(Gross_Profit), 2) AS Highest_Profit
FROM
    sales
GROUP BY Channel
ORDER BY Highest_Profit DESC
LIMIT 1;

-- Insight: Online channel has the highest profit, approximately 321923323.19


-- =====================================================================
-- SECTION 3: CUSTOMER ANALYSIS
-- =====================================================================

-- 12. Who are the top 10 customers by revenue?
SELECT 
    Customer_ID, 
    ROUND(SUM(Net_Revenue), 2) AS Total_Revenue
FROM
    sales
GROUP BY Customer_ID
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Insight: Highest revenue is from customer C0030 and lowest in the top 10 is from C1554.


-- 13. Which region has the highest number of unique customers?
SELECT 
    Region,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM
    sales
GROUP BY Region
ORDER BY Unique_Customers DESC;

-- Insight: Central region has the highest number of unique customers and West has the lowest.


-- =====================================================================
-- SECTION 4: BUDGET VS ACTUAL ANALYSIS
-- =====================================================================

-- 14. What is the variance between budgeted revenue and actual revenue?
SELECT 
    SUM(b.Budget_Revenue) AS Total_B_Revenue,
    SUM(s.Actual_Revenue) AS Total_A_Revenue,
    SUM(s.Actual_Revenue) - SUM(b.Budget_Revenue) AS Variance
FROM
    (SELECT 
        DATE_FORMAT(Date, '%Y-%m') AS Month,
        Product_ID,
        SUM(Budget_Revenue) AS Budget_Revenue
    FROM
        budget
    GROUP BY DATE_FORMAT(Date, '%Y-%m'), Product_ID) AS b
        JOIN
    (SELECT 
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        Product_ID,
        SUM(Net_Revenue) AS Actual_Revenue
    FROM
        sales
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m'), Product_ID) AS s 
    ON b.Month = s.Month
        AND b.Product_ID = s.Product_ID;

-- Insight: Variance between budget revenue and actual revenue is approximately -620172916.95


-- 15. Which months have actual revenue lower than budgeted revenue?
SELECT 
    b.Month,
    b.Budget_Revenue,
    COALESCE(s.Actual_Revenue, 0) AS Actual_Revenue,
    COALESCE(s.Actual_Revenue, 0) - b.Budget_Revenue AS Variance
FROM
    (SELECT 
        DATE_FORMAT(Date, '%Y-%m') AS Month,
        SUM(Budget_Revenue) AS Budget_Revenue
    FROM budget
    GROUP BY DATE_FORMAT(Date, '%Y-%m')) b
LEFT JOIN
    (SELECT 
        DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
        SUM(Net_Revenue) AS Actual_Revenue
    FROM sales
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')) s
    ON b.Month = s.Month
WHERE COALESCE(s.Actual_Revenue, 0) < b.Budget_Revenue
ORDER BY b.Month;
