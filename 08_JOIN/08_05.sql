SELECT a.user_id AS user_id_left,
       b.user_id AS user_id_right,
       order_id,
       time,
       action,
       sex,
       birth_date
FROM user_actions a
LEFT JOIN users b USING (user_id)
WHERE b.user_id IS NOT NULL
ORDER BY user_id_left;
