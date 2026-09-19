WITH category_state_revenue AS (
  SELECT 
    p.product_category_name,
    s.seller_state,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS category_state_revenue,
    RANK() OVER (PARTITION BY s.seller_state ORDER BY SUM(oi.price + oi.freight_value) DESC) AS category_rank_in_state
  FROM order_items oi
  JOIN orders o ON oi.order_id = o.order_id
  JOIN products p ON oi.product_id = p.product_id
  JOIN sellers s ON oi.seller_id = s.seller_id
  WHERE o.order_status = 'delivered'
  GROUP BY p.product_category_name, s.seller_state
)
SELECT 
  product_category_name,
  seller_state,
  category_state_revenue,
  category_rank_in_state
FROM category_state_revenue
WHERE category_rank_in_state <= 10
ORDER BY seller_state, category_rank_in_state;
