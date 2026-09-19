SELECT 
  DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS month,
  ROUND(SUM(oi.price + oi.freight_value), 2) AS monthly_revenue,
  ROUND(
    ((SUM(oi.price + oi.freight_value) - 
      LAG(SUM(oi.price + oi.freight_value)) OVER (ORDER BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01'))) 
     / LAG(SUM(oi.price + oi.freight_value)) OVER (ORDER BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01'))) * 100, 
    2
  ) AS mom_growth_pct,
  ROUND(
    SUM(SUM(oi.price + oi.freight_value)) OVER (ORDER BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01')), 
    2
  ) AS running_total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01')
ORDER BY month;
