SELECT a.birth_date AS users_birth_date,
       users_count,
       b.birth_date AS couriers_birth_date,
       couriers_count
FROM (
    SELECT birth_date,
           COUNT(user_id) AS users_count
    FROM users
    WHERE birth_date IS NOT NULL
    GROUP BY birth_date
) a
FULL JOIN (
    SELECT birth_date,
           COUNT(courier_id) AS couriers_count
    FROM couriers
    WHERE birth_date IS NOT NULL
    GROUP BY birth_date
) b USING (birth_date)
ORDER BY users_birth_date, couriers_birth_date
