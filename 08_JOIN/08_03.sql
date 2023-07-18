SELECT a.user_id AS user_id_left, u.user_id AS user_id_right,  order_id, time, action, sex, u.birth_date
FROM user_actions AS a
LEFT JOIN
users AS u
USING(user_id)
ORDER BY user_id_left
