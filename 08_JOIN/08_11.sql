SELECT user_id,
       ROUND(AVG(array_length(product_ids, 1)), 2) AS avg_order_size
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
GROUP BY user_id
ORDER BY user_id
LIMIT 1000;
