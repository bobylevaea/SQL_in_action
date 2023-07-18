SELECT user_id,
       name
FROM (
    SELECT user_id
    FROM users
    LIMIT 100
) t1
CROSS JOIN (
    SELECT name
    FROM products
) t2
ORDER BY user_id, name;
