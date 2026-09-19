WITH seller_revenue AS (
  SELECT 
    s.seller_id,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS seller_total_revenue,
    ROUND(
      SUM(SUM(oi.price + oi.freight_value)) OVER (ORDER BY SUM(oi.price + oi.freight_value) DESC), 
      2
    ) AS cumulative_revenue
  FROM order_items oi
  JOIN orders o ON oi.order_id = o.order_id
  JOIN sellers s ON oi.seller_id = s.seller_id
  WHERE o.order_status = 'delivered'
  GROUP BY s.seller_id
),
total_revenue AS (
  SELECT SUM(seller_total_revenue) AS grand_total FROM seller_revenue
)
SELECT 
  sr.seller_id,
  sr.seller_total_revenue,
  sr.cumulative_revenue,
  ROUND((sr.cumulative_revenue / tr.grand_total) * 100, 2) AS pct_of_total_revenue,
  CASE 
    WHEN (sr.cumulative_revenue / tr.grand_total) <= 0.80 THEN 'Top 80% (Vital Few)'
    ELSE 'Bottom 20% (Trivial Many)'
  END AS pareto_classification
FROM seller_revenue sr, total_revenue tr
ORDER BY sr.cumulative_revenue DESC;
