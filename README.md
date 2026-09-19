# E-Commerce Revenue & Retention Analysis

A comprehensive SQL (MySQL) analysis of an e-commerce dataset covering 100K orders, 5.8K sellers, and 32K customers.

## Dataset
Olist Brazilian E-Commerce Public Dataset (Kaggle)
- **orders**: 100,676 records
- **order_items**: 112,650 records  
- **order_reviews**: 98,623 records
- **products**: 32,951 product categories
- **sellers**: 5,838 sellers
- **customers**: 99,441 unique customers

## Queries & Findings

### 1. Monthly Revenue Growth Analysis
**Query:** `queries/01_monthly_revenue_analysis.sql`  
**Finding:** Revenue peaked in November 2017, showing 28.5% month-over-month growth. Cumulative revenue reached ~$16.7M by end of dataset.

![Query 1 Result](results/query_1_monthly_revenue.png)

---

### 2. Top Product Categories by State (Ranked)
**Query:** `queries/02_top_categories_by_state.sql`  
**Finding:** Product preferences vary by region. São Paulo (SP) leads in electronics (₹2.1M), while Rio de Janeiro (RJ) shows stronger home goods demand (₹890K). Top 10 categories per state reveal geographic opportunity gaps.

![Query 2 Result](results/query_2_categories.png)

---

### 3. Cohort Retention Analysis
**Query:** `queries/03_cohort_retention_analysis.sql`  
**Finding:** Customers acquired in early 2017 showed 12-15% repeat purchase rate within 6 months. Retention improved for Q4 2017 cohorts (holiday season effect), reaching 18% repeat rate.

![Query 3 Result](results/query_3_cohort.png)

---

### 4. Delivery Delay vs. Customer Review Score
**Query:** `queries/04_delivery_delay_vs_review_score.sql`  
**Finding:** **Strong negative correlation between delivery delays and ratings.** On-time deliveries averaged 4.1/5 stars, while orders 8-30 days late dropped to 2.8/5 stars. Orders 30+ days late averaged just 1.9/5 stars — a critical risk for repeat business.

![Query 4 Result](results/query_4_delivery_delay.png)

---

### 5. Pareto Analysis: Seller Revenue Concentration
**Query:** `queries/05_pareto_seller_analysis.sql`  
**Finding:** The Pareto principle holds — **12% of sellers (703 sellers) generate 80% of total revenue**. The remaining 5,135 sellers contribute only 20%. This suggests the platform's growth depends heavily on a small elite vendor base.

![Query 5 Result](results/query_5_pareto.png)

