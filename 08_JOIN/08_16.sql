SELECT coalesce(sex, 'unknown') AS sex,
       ROUND(AVG(cancel_rate), 3) AS avg_cancel_rate
FROM (
    SELECT user_id,
           sex,
           COUNT(DISTINCT order_id) FILTER (WHERE action = 'cancel_order')::DECIMAL / COUNT(DISTINCT order_id) AS cancel_rate
    FROM user_actions
    LEFT JOIN users USING (user_id)
    GROUP BY user_id, sex
    ORDER BY cancel_rate DESC
) t
GROUP BY sex
ORDER BY sex;
