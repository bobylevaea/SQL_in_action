SELECT COUNT(DISTINCT a.user_id) AS users_count
FROM user_actions a
JOIN users b USING (user_id);
