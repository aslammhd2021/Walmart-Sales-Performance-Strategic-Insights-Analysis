
/* ============================================================
   SECTION 1: STORE PERFORMANCE ANALYSIS
============================================================ */

-- 1.1 Total Revenue by Store
SELECT
    Store,
    ROUND(SUM(Weekly_Sales), 2) AS total_revenue
FROM train
GROUP BY Store
ORDER BY total_revenue DESC;


-- 1.2 Store Revenue Contribution (% of Total Sales)
SELECT
    Store,
    SUM(Weekly_Sales) AS store_revenue,
    ROUND(
        SUM(Weekly_Sales) /
        (SELECT SUM(Weekly_Sales) FROM train) * 100,
        2
    ) AS revenue_percentage
FROM train
GROUP BY Store
ORDER BY store_revenue DESC;


-- 1.3 Store Volatility & Risk Score
SELECT
    Store,
    AVG(Weekly_Sales) AS avg_sales,
    STDDEV(Weekly_Sales) AS volatility,
    STDDEV(Weekly_Sales) / AVG(Weekly_Sales) AS risk_score
FROM train
GROUP BY Store
ORDER BY risk_score DESC;



/* ============================================================
   SECTION 2: DEPARTMENT PERFORMANCE
============================================================ */

-- 2.1 Department Revenue
SELECT
    Dept,
    SUM(Weekly_Sales) AS total_sales
FROM train
GROUP BY Dept
ORDER BY total_sales DESC;


-- 2.2 Department Contribution %
SELECT
    Dept,
    SUM(Weekly_Sales) AS dept_sales,
    ROUND(
        SUM(Weekly_Sales) /
        (SELECT SUM(Weekly_Sales) FROM train) * 100,
        2
    ) AS contribution_pct
FROM train
GROUP BY Dept
ORDER BY dept_sales DESC;


-- 2.3 Department Seasonality Score
SELECT
    Dept,
    AVG(Weekly_Sales) AS avg_sales,
    STDDEV(Weekly_Sales) AS volatility,
    STDDEV(Weekly_Sales) / AVG(Weekly_Sales) AS seasonality_score
FROM train
GROUP BY Dept
ORDER BY seasonality_score DESC;



/* ============================================================
   SECTION 3: HOLIDAY IMPACT
============================================================ */

-- 3.1 Overall Holiday Lift
SELECT
    AVG(CASE WHEN IsHoliday = 1 THEN Weekly_Sales END) AS holiday_avg_sales,
    AVG(CASE WHEN IsHoliday = 0 THEN Weekly_Sales END) AS normal_avg_sales,
    (AVG(CASE WHEN IsHoliday = 1 THEN Weekly_Sales END) -
     AVG(CASE WHEN IsHoliday = 0 THEN Weekly_Sales END)) AS extra_sales,
    ((AVG(CASE WHEN IsHoliday = 1 THEN Weekly_Sales END) -
      AVG(CASE WHEN IsHoliday = 0 THEN Weekly_Sales END)) /
      AVG(CASE WHEN IsHoliday = 0 THEN Weekly_Sales END)) * 100
      AS holiday_lift_pct
FROM train;


-- 3.2 Holiday Lift by Store
SELECT
    Store,
    ((AVG(CASE WHEN IsHoliday = 1 THEN Weekly_Sales END) -
      AVG(CASE WHEN IsHoliday = 0 THEN Weekly_Sales END)) /
      AVG(CASE WHEN IsHoliday = 0 THEN Weekly_Sales END)) * 100
      AS holiday_lift_pct
FROM train
GROUP BY Store
ORDER BY holiday_lift_pct DESC;



/* ============================================================
   SECTION 4: EXTERNAL FACTORS ANALYSIS
============================================================ */

-- 4.1 Fuel Price Impact
SELECT
    CASE
        WHEN Fuel_Price < 3 THEN 'Low Fuel'
        WHEN Fuel_Price BETWEEN 3 AND 3.5 THEN 'Medium Fuel'
        ELSE 'High Fuel'
    END AS fuel_level,
    AVG(Weekly_Sales) AS avg_sales
FROM train t
LEFT JOIN features f
    ON t.Store = f.Store AND t.Date = f.Date
GROUP BY fuel_level
ORDER BY avg_sales DESC;


-- 4.2 CPI Impact
SELECT
    CASE
        WHEN CPI < 170 THEN 'Low CPI'
        WHEN CPI BETWEEN 170 AND 190 THEN 'Medium CPI'
        ELSE 'High CPI'
    END AS cpi_level,
    AVG(Weekly_Sales) AS avg_sales
FROM train t
LEFT JOIN features f
    ON t.Store = f.Store AND t.Date = f.Date
GROUP BY cpi_level
ORDER BY avg_sales DESC;


-- 4.3 Unemployment Impact
SELECT
    CASE
        WHEN Unemployment < 6 THEN 'Low Unemployment'
        WHEN Unemployment BETWEEN 6 AND 8 THEN 'Medium Unemployment'
        ELSE 'High Unemployment'
    END AS unemployment_level,
    AVG(Weekly_Sales) AS avg_sales
FROM train t
LEFT JOIN features f
    ON t.Store = f.Store AND t.Date = f.Date
GROUP BY unemployment_level
ORDER BY avg_sales DESC;



/* ============================================================
   SECTION 5: TIME SERIES ANALYSIS
============================================================ */

-- 5.1 Weekly Trend
SELECT
    Date,
    SUM(Weekly_Sales) AS total_weekly_sales
FROM train
GROUP BY Date
ORDER BY Date;


-- 5.2 Monthly Pattern
SELECT
    MONTH(Date) AS month,
    AVG(Weekly_Sales) AS avg_sales
FROM train
GROUP BY MONTH(Date)
ORDER BY month;



/* ============================================================
   SECTION 6: FORECAST MODEL (4-Week Moving Average)
============================================================ */

SELECT
    t.Store,
    t.Dept,
    t.Date,
    t.Weekly_Sales,
    AVG(t.Weekly_Sales) OVER (
        PARTITION BY t.Store, t.Dept
        ORDER BY t.Date
        ROWS BETWEEN 4 PRECEDING AND 1 PRECEDING
    ) AS baseline_forecast
FROM train t;
