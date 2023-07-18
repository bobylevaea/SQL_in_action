SELECT order_id
FROM (
    SELECT order_id,
           time AS delivery_time
    FROM courier_actions
    WHERE action = 'deliver_order'
) AS t
LEFT JOIN orders USING (order_id)
ORDER BY delivery_time - creation_time DESC
LIMIT 10;
