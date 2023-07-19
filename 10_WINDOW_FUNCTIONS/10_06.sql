SELECT 
    user_id,
    order_id,
    time,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY time) AS order_number,
    LAG(time, 1) OVER (PARTITION BY user_id ORDER BY time) AS time_lag, 
    AGE(time, LAG(time, 1) OVER (PARTITION BY user_id ORDER BY time)) AS time_diff
FROM 
    user_actions
WHERE 
    order_id NOT IN (
        SELECT order_id FROM user_actions WHERE action = 'cancel_order'
    )
ORDER BY 
    user_id,
    order_number
LIMIT 1000;
