SELECT user_id,
       COUNT(order_price) AS orders_count,
       ROUND(avg(order_size), 2) AS avg_order_size,
       SUM(order_price) AS sum_order_value,
       ROUND(avg(order_price), 2) AS avg_order_value,
       MIN(order_price) AS min_order_value,
       MAX(order_price) AS max_order_value
FROM (
    SELECT user_id,
           order_id,
           array_length(product_ids, 1) AS order_size
    FROM (
        SELECT user_id,
               order_id
        FROM user_actions
        WHERE order_id NOT IN (
            SELECT order_id
            FROM user_actions
            WHERE action = 'cancel_order'
        )
    ) t1
    LEFT JOIN orders USING (order_id)
) t2
LEFT JOIN (
    SELECT order_id,
           SUM(price) AS order_price
    FROM (
        SELECT order_id,
               product_ids,
               unnest(product_ids) AS product_id
        FROM orders
        WHERE order_id NOT IN (
            SELECT order_id
            FROM user_actions
            WHERE action = 'cancel_order'
        )
    ) t3
    LEFT JOIN products USING (product_id)
    GROUP BY order_id
) t4 USING (order_id)
GROUP BY user_id
ORDER BY user_id
LIMIT 1000;
