SELECT order_id,
       product_id,
       price
FROM (
    SELECT order_id,
           product_ids,
           unnest(product_ids) AS product_id
    FROM orders
) AS t
LEFT JOIN products USING (product_id)
ORDER BY order_id, product_id
LIMIT 1000;
