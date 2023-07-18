SELECT name,
       COUNT(product_id) AS times_purchased
FROM (
    SELECT order_id,
           product_id,
           name
    FROM (
        SELECT DISTINCT order_id,
                        unnest(product_ids) AS product_id
        FROM orders
        LEFT JOIN courier_actions USING (order_id)
        WHERE action = 'deliver_order'
        AND date_part('month', time) = 9
        AND date_part('year', time) = 2022
    ) t1
    LEFT JOIN products USING (product_id)
) t2
GROUP BY name
ORDER BY times_purchased DESC
LIMIT 10;
