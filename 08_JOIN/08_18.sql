SELECT order_id,
       array_agg(name) AS product_names
FROM (
    SELECT order_id,
           unnest(product_ids) AS product_id
    FROM orders
) t
JOIN products USING (product_id)
GROUP BY order_id
LIMIT 1000;
