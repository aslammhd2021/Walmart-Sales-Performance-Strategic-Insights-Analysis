

# 🏪 Walmart Sales Performance & Strategic Insights Analysis

## 📌 Project Overview

This project analyzes Walmart’s historical weekly sales data to uncover revenue drivers, seasonal patterns, external factor impacts, and business risks.

The goal is to transform raw transactional data into actionable insights using SQL and visualize them using Power BI.

This project simulates real-world business intelligence work performed by a data analyst.

---

## 🎯 Business Problem

Walmart operates multiple stores and departments across different regions. Management needs answers to key strategic questions:

* Which stores generate the highest revenue?
* Which departments contribute most to total sales?
* How do holidays impact weekly performance?
* Do fuel price, inflation (CPI), and unemployment affect sales?
* Which stores or departments show unstable performance?
* Can we create a simple forecasting model for future planning?

This project answers these questions using structured SQL analysis.

---

## 🛠 Tools & Technologies

* **SQL** – Data analysis and business logic
* **Excel** – Data cleaning and preprocessing
* **Power BI** – Dashboard visualization
* **GitHub** – Version control & portfolio presentation

---

## 📂 Dataset Description

The dataset consists of:

* `train` – Weekly sales by store and department
* `features` – External economic and promotional variables
* `stores` – Store metadata (type and size)

Key Columns:

* Store
* Dept
* Date
* Weekly_Sales
* IsHoliday
* Temperature
* Fuel_Price
* CPI
* Unemployment
* MarkDown1–5

---

## 📊 Analysis Performed

### 1️⃣ Store Performance Analysis

* Total revenue by store
* Revenue contribution percentage
* Store-level volatility & risk score

### 2️⃣ Department Performance Analysis

* Top revenue-generating departments
* Department contribution %
* Seasonality score (Volatility / Average Sales)

### 3️⃣ Holiday Impact Analysis

* Holiday vs Non-Holiday average sales
* Holiday lift percentage
* Store-level holiday sensitivity

### 4️⃣ External Factor Analysis

* Impact of Fuel Price on sales
* Impact of CPI (Inflation)
* Impact of Unemployment
* Promotion vs Non-Promotion performance

### 5️⃣ Time Series Analysis

* Weekly sales trend
* Monthly seasonal patterns
* Peak sales identification

### 6️⃣ Risk & Stability Classification

Stores and departments classified into:

* Stable
* Moderate Risk
* High Risk

Using:
Risk Score = STDDEV(Weekly_Sales) / AVG(Weekly_Sales)

### 7️⃣ Forecasting Model

A 4-week moving average model was built using SQL window functions to estimate baseline sales.

Additionally, holiday-adjusted forecasting was implemented.

---

## 📈 Key Insights

* A small number of stores contribute a significant percentage of total revenue.
* Certain departments show strong seasonal volatility.
* Holiday weeks generate measurable sales lift.
* External economic indicators show moderate correlation with sales.
* Some stores demonstrate high volatility and operational risk.
* Moving average forecasting provides a stable short-term projection model.

---

## 📊 Dashboard Preview

<img width="1289" height="719" alt="image" src="https://github.com/user-attachments/assets/80afd20d-28f4-454c-b9de-c354b9070b1f" />

The Power BI dashboard includes:

* Executive Summary KPIs
* Top 5 Stores & Departments
* Holiday vs Non-Holiday Sales
* Inflation Impact Visualization
* Weekly Sales Trend
* Risk Analysis

---

## 💡 Business Recommendations

* Focus inventory planning on high-performing departments.
* Prepare inventory surge strategies for holiday weeks.
* Monitor high-risk stores for operational improvements.
* Use short-term moving average forecasts for weekly planning.
* Track external economic indicators for macro-level adjustments.

