SELECT date,
       orders_count,
       SUM(orders_count) OVER (ORDER BY date)::integer AS orders_cum_count
FROM (
    SELECT DATE(creation_time) AS date,
           COUNT(order_id) AS orders_count
    FROM orders
    WHERE order_id NOT IN (
        SELECT order_id
        FROM user_actions
        WHERE action = 'cancel_order'
    )
    GROUP BY date
) t;
