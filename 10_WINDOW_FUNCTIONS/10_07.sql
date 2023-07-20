SELECT 
    user_id,
    AVG(time_diff)::integer AS hours_between_orders
FROM (
    SELECT 
        user_id,
        order_id,
        time,
        EXTRACT(epoch FROM (time - LAG(time, 1) OVER (PARTITION BY user_id ORDER BY time))) / 3600 AS time_diff
    FROM 
        user_actions
    WHERE 
        order_id NOT IN (
            SELECT order_id
            FROM user_actions
            WHERE action = 'cancel_order'
        )
) t
WHERE time_diff IS NOT NULL
GROUP BY user_id
ORDER BY user_id
LIMIT 1000;
