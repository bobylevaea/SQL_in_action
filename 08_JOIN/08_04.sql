SELECT COUNT (DISTINCT a.user_id) AS users_count
FROM user_actions AS a
LEFT JOIN
users AS u
USING(user_id)
