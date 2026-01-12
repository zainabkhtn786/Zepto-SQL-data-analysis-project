-- ====================================================
-- Zepto Data Analysis Project – SQL
-- Author: Zainab Khatoon
-- Purpose: Data exploration, cleaning, and business analysis
-- ====================================================

-- -------------------- Database & Table Creation --------------------
DROP TABLE IF EXISTS zepto;

CREATE DATABASE IF NOT EXISTS zepto_db;
USE zepto_db;

CREATE TABLE zepto (
    category VARCHAR(120),
    name VARCHAR(150),
    mrp INT,
    discountPercent INT,
    availableQuantity INT,
    discountedSellingPrice INT,
    weightInGms INT,
    outOfStock VARCHAR(10),
    quantity INT
);

ALTER TABLE zepto
ADD COLUMN sku_id INT AUTO_INCREMENT PRIMARY KEY FIRST;
-- SKU ID added as a surrogate primary key for unique product identification


-- -------------------- Data Exploration --------------------

-- Total rows
SELECT COUNT(*) FROM zepto;

-- Sample records
SELECT * FROM zepto LIMIT 10;

-- Check for null values
SELECT * FROM zepto
WHERE name IS NULL
OR category IS NULL
OR mrp IS NULL
OR discountPercent IS NULL
OR discountedSellingPrice IS NULL
OR weightInGms IS NULL
OR availableQuantity IS NULL
OR outOfStock IS NULL
OR quantity IS NULL;

-- Distinct product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- Standardize outOfStock as numeric
UPDATE zepto
SET outOfStock =
CASE
    WHEN outOfStock = 'TRUE' THEN 1
    ELSE 0
END;

SELECT DISTINCT outOfStock FROM zepto;

-- Products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id) AS product_count
FROM zepto
GROUP BY outOfStock;


-- -------------------- Data Cleaning --------------------

-- Identify products with invalid prices
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- Remove invalid price records
DELETE FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- Convert prices from paise to rupees (if required)
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0
WHERE mrp > 1000;

-- Validate updated prices
SELECT mrp, discountedSellingPrice FROM zepto;


-- ===============================
-- DATA ANALYSIS – BUSINESS QUESTIONS
-- ===============================

-- Q1. Top 10 best-value products by discount percentage
SELECT 
    name,
    MAX(mrp) AS mrp,
    MAX(discountPercent) AS discountPercent
FROM zepto
GROUP BY name
ORDER BY discountPercent DESC
LIMIT 10;

/* Business Insight:
Identifies products with the highest discount percentages.
Promote these items to attract price-sensitive customers.
*/


-- Q2. High-MRP products that are out of stock (revenue risk)
SELECT 
    name,
    mrp,
    discountedSellingPrice
FROM zepto
WHERE outOfStock = 1
  AND mrp > 300
ORDER BY mrp DESC;

/* Business Insight:
Out-of-stock high-MRP products represent direct revenue loss.
Prioritize restocking these premium items.
*/


-- Q3. Category-wise potential revenue from in-stock products
SELECT 
    category,
    ROUND(SUM(discountedSellingPrice * availableQuantity), 0) AS potential_revenue
FROM zepto
WHERE outOfStock = 0
GROUP BY category
ORDER BY potential_revenue DESC;

/* Business Insight:
Few categories drive most of the potential revenue.
Focus inventory, promotions, and supply chain efforts on these categories.
*/


-- Q4. Premium products (MRP > ₹500, discount < 10%)
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

/* Business Insight:
Premium items with minimal discounts maintain strong margins.
Aggressive promotions may not be necessary.
*/


-- Q5. Categories with high average discount but low revenue
SELECT 
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount,
    ROUND(SUM(discountedSellingPrice * availableQuantity), 0) AS total_revenue
FROM zepto
WHERE outOfStock = 0
GROUP BY category
ORDER BY avg_discount DESC, total_revenue ASC
LIMIT 10;

/* Business Insight:
High discount does not always boost revenue.
Review product assortment, visibility, and demand-driven pricing.
*/


-- Q6. Top revenue-generating products (Pareto Analysis)
SELECT 
    name,
    category,
    SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
WHERE outOfStock = 0
GROUP BY name, category
ORDER BY total_revenue DESC
LIMIT 10;

/* Business Insight:
A small number of products generate the majority of revenue.
Prioritize these for stock, marketing, and supplier negotiations.
*/


-- Q7. Revenue at risk due to out-of-stock products
SELECT 
    category,
    ROUND(SUM(mrp * quantity), 0) AS revenue_at_risk
FROM zepto
WHERE outOfStock = 1
GROUP BY category
ORDER BY revenue_at_risk DESC;

/* Business Insight:
Out-of-stock products indicate revenue risk.
Prioritize restocking high-demand categories.
*/


-- Q8. Category-wise revenue contribution (% of total)
SELECT 
    category,
    ROUND(SUM(discountedSellingPrice * availableQuantity), 0) AS category_revenue,
    ROUND(
        100.0 * SUM(discountedSellingPrice * availableQuantity) /
        (SELECT SUM(discountedSellingPrice * availableQuantity)
         FROM zepto
         WHERE outOfStock = 0),
    2) AS revenue_percentage
FROM zepto
WHERE outOfStock = 0
GROUP BY category
ORDER BY revenue_percentage DESC;

/* Business Insight:
Revenue is concentrated in few categories.
Focus inventory and promotions on these to maximize returns.
*/


-- Q9. High-MRP products with heavy discounts (Margin Risk)
SELECT 
    name,
    category,
    mrp,
    discountedSellingPrice,
    discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent > 40
ORDER BY discountPercent DESC, mrp DESC;

/* Business Insight:
Heavy discounts on expensive products erode margins.
Implement demand-based or strategic discounting.
*/


-- Q10. Best value-for-money products (price per gram)
SELECT 
    name,
    category,
    weightInGms,
    discountedSellingPrice,
    availableQuantity,
    ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
  AND outOfStock = 0
ORDER BY price_per_gram ASC
LIMIT 20;

/* Business Insight:
Products with lower price per gram offer better value.
Use for promotions, bundles, and pricing decisions.
*/


-- Q11. Product distribution by weight category (Low / Medium / Bulk)
SELECT 
    CASE 
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category,
    COUNT(*) AS product_count
FROM zepto
GROUP BY weight_category;

/* Business Insight:
Low and medium weight products cater to households.
Bulk products serve institutional/family demand requiring different planning.
*/


-- Q12. Total inventory weight per category (in-stock only)
SELECT 
    category,
    SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto
WHERE outOfStock = 0
GROUP BY category
ORDER BY total_inventory_weight DESC;

/* Business Insight:
High-weight categories consume more storage/logistics.
Optimize inventory to reduce costs and improve efficiency.
*/


-- ===============================
-- FINAL BUSINESS RECOMMENDATIONS
-- ===============================

/* Final Business Recommendations:

1. Prioritize restocking of high-revenue and high-MRP products
   to prevent revenue loss from stockouts.

2. Optimize discount strategies:
   - Avoid blanket discounts for low-performing categories.
   - Reduce aggressive discounts on high-MRP items to protect margins.
   - Highlight value-for-money products based on price-per-gram analysis.

3. Focus marketing efforts on top revenue-generating products
   following the Pareto (80/20) principle.

4. Allocate inventory and warehouse resources toward:
   - Categories contributing the highest revenue
   - Categories with high inventory weight to optimize storage and logistics.

5. Leverage premium products with low discounts:
   - Maintain strong pricing power without unnecessary promotions.
*/
