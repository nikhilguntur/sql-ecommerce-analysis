WITH first_purchase AS (
  SELECT 
    o.customer_id,
    DATE_FORMAT(MIN(o.order_purchase_timestamp), '%Y-%m') AS cohort_month
  FROM orders o
  GROUP BY o.customer_id
),
customer_purchases AS (
  SELECT 
    o.customer_id,
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS purchase_month
  FROM orders o
  WHERE o.order_status = 'delivered'
  GROUP BY o.customer_id, DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
)
SELECT 
  fp.cohort_month,
  PERIOD_DIFF(DATE_FORMAT(cp.purchase_month, '%Y%m'), DATE_FORMAT(fp.cohort_month, '%Y%m')) AS months_since_first,
  COUNT(DISTINCT cp.customer_id) AS customers_active,
  ROUND(
    (COUNT(DISTINCT cp.customer_id) / 
     (SELECT COUNT(DISTINCT customer_id) FROM first_purchase WHERE cohort_month = fp.cohort_month)) * 100, 
    2
  ) AS retention_pct
FROM first_purchase fp
JOIN customer_purchases cp ON fp.customer_id = cp.customer_id 
  AND cp.purchase_month >= fp.cohort_month
GROUP BY fp.cohort_month, PERIOD_DIFF(DATE_FORMAT(cp.purchase_month, '%Y%m'), DATE_FORMAT(fp.cohort_month, '%Y%m'))
ORDER BY fp.cohort_month, months_since_first;
