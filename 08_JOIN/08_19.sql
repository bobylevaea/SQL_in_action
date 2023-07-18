WITH order_id_large_size AS (
    SELECT order_id
    FROM orders
    WHERE array_length(product_ids, 1) = (
        SELECT MAX(array_length(product_ids, 1))
        FROM orders
    )
)
SELECT DISTINCT
    order_id,
    user_id,
    DATE_PART('year', AGE((SELECT MAX(time) FROM user_actions), users.birth_date))::INTEGER AS user_age,
    courier_id,
    DATE_PART('year', AGE((SELECT MAX(time) FROM user_actions), couriers.birth_date))::INTEGER AS courier_age
FROM (
    SELECT order_id, user_id
    FROM user_actions
    WHERE order_id IN (SELECT order_id FROM order_id_large_size)
) t1
LEFT JOIN (
    SELECT order_id, courier_id
    FROM courier_actions
    WHERE order_id IN (SELECT order_id FROM order_id_large_size)
) t2 USING (order_id)
LEFT JOIN users USING (user_id)
LEFT JOIN couriers USING (courier_id)
ORDER BY order_id;
