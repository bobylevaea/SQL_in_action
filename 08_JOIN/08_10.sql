SELECT user_id,
       order_id,
       product_ids
FROM (
    SELECT user_id,
           order_id
    FROM user_actions
    WHERE order_id NOT IN (
        SELECT order_id
        FROM user_actions
        WHERE action = 'cancel_order'
    )
) t
LEFT JOIN orders USING (order_id)
ORDER BY user_id, order_id
LIMIT 1000;
