# 🛒 Zepto E-Commerce Data Analysis (SQL Project)
!https://bizbracket.in/wp-content/uploads/2024/08/Zepto-Grocery-Delivery-1068x601.jpg
## 📌 Project Overview

This project analyzes a Zepto-like online grocery dataset using SQL to uncover insights related to inventory management, pricing, discounts, and revenue performance.

The goal is to help business and operations teams make data-driven decisions that improve stock availability, protect margins, and maximize revenue.

⚠️ This is a SQL-only project (no charts), designed to demonstrate strong analytical thinking, SQL proficiency, and business insight generation.

## 🧩 Business Problem

Online grocery platforms face several operational challenges:

📉 Revenue loss due to out-of-stock products

💸 Margin erosion from aggressive discounting

📦 Overstocking in low-demand categories

🔍 Difficulty identifying high-value products and categories

⚖️ Inefficient inventory allocation across categories

## 🎯 Project Objectives

Using SQL, this project aims to:

Identify revenue-driving products and categories

Quantify revenue at risk due to stockouts

Analyze whether discounts actually drive revenue

Detect pricing and margin risks

Support inventory, pricing, and promotion decisions with data-backed insights

## 🛠️ Tools & Skills Used

MySQL

SQL Techniques:

Aggregations (SUM, AVG, COUNT)

CASE statements

Subqueries

Filtering & grouping

Data cleaning & validation

Business analysis & insight storytelling

## 🗂️ Dataset Description

The dataset contains product-level information including:

sku_id – Unique product identifier

category – Product category

name – Product name

mrp – Maximum Retail Price

discountPercent – Discount offered

discountedSellingPrice – Final selling price

availableQuantity – Inventory available

outOfStock – Stock availability flag

weightInGms – Product weight

quantity – Unit quantity

## 🔄 Data Cleaning & Preparation

Key data preparation steps:

Removed products with invalid prices (MRP = 0 or Selling Price = 0)

Converted prices from paise to rupees

Standardized outOfStock values into binary flags

Checked and handled null values

Added a surrogate primary key (SKU ID)

✔️ Result: A clean, reliable dataset ready for business analysis.

## 📊 Business Questions Answered

The analysis answers practical business questions such as:

Which products offer the highest discounts?

Which high-MRP products are out of stock, causing revenue risk?

Which categories generate the highest potential revenue?

Are heavy discounts translating into revenue?

Which products follow the Pareto (80/20) revenue rule?

How much revenue is at risk due to stockouts?

Which categories contribute the highest percentage of total revenue?

Which products pose margin risk due to high MRP and high discounts?

Which products offer the best value for money (price per gram)?

How is inventory distributed across Low / Medium / Bulk weight categories?

Which categories consume the most warehouse and logistics capacity?

## 🔍 Key Insights

A small number of products drive a large share of total revenue (Pareto principle).

High-MRP stockouts result in significant revenue loss.

Some categories rely heavily on discounts but still underperform, indicating poor pricing efficiency.

High-MRP + high-discount products pose serious margin risks.

Value-for-money products (low price per gram) are ideal for bundles and promotions.

Categories with heavy inventory weight drive higher logistics and storage costs.

## Analysis Summary

The SQL analysis was structured into the following themes:

- **Pricing & Discount Analysis**
  - Identified highly discounted products
  - Flagged high-MRP products with margin risk

- **Inventory & Stock Availability**
  - Measured revenue at risk due to stockouts
  - Identified categories requiring urgent restocking

- **Revenue & Category Performance**
  - Calculated category-wise potential revenue
  - Measured contribution percentage to total revenue

- **Product Value Assessment**
  - Evaluated value-for-money using price-per-gram analysis
  - Classified products into Low / Medium / Bulk categories

- **Operational Efficiency**
  - Analyzed inventory weight to assess warehouse and logistics impact


## 📌 Final Business Recommendations

Prioritize restocking high-revenue and high-MRP products to prevent revenue loss.

Optimize discount strategies instead of applying blanket discounts.

Focus marketing efforts on top revenue-generating products (80/20 rule).

Reduce aggressive discounts on premium products to protect margins.

Allocate inventory budgets toward high-contributing categories.

Optimize warehouse space for high inventory weight categories.

Promote value-for-money products based on price-per-gram analysis.

## 📁 Project Structure
Zepto-SQL-Analysis/
│
├── zepto_sql_analysis.sql   # SQL queries with insights
└── README.md               # Project documentation

## 🚀 Project Outcome

This project demonstrates the ability to:

Translate business problems into SQL queries

Perform structured data analysis

Generate actionable business insights using SQL alone

### 📌 Ideal for showcasing SQL, analytical thinking, and business acumen in Data Analyst / Business Analyst roles.
