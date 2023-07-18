SELECT a.user_id AS user_id_left,
       b.user_id AS user_id_right,
       order_id,
       time,
       action,
       sex,
       birth_date
FROM user_actions a
JOIN users b USING (user_id)
ORDER BY user_id_left;
