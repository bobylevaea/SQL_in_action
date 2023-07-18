WITH main_table AS (
    SELECT DISTINCT
        order_id,
        product_id,
        name
    FROM (
        SELECT
            order_id,
            unnest(product_ids) AS product_id
        FROM
            orders
        WHERE
            order_id NOT IN (
                SELECT order_id
                FROM user_actions
                WHERE action = 'cancel_order'
            )
            AND order_id IN (
                SELECT order_id
                FROM user_actions
                WHERE action = 'create_order'
            )
    ) t
    JOIN products USING (product_id)
    ORDER BY order_id, name
)
SELECT
    pair,
    COUNT(order_id) AS count_pair
FROM (
    SELECT DISTINCT
        a.order_id,
        CASE WHEN a.name > b.name THEN string_to_array(concat(b.name, '+', a.name), '+')
             ELSE string_to_array(concat(a.name, '+', b.name), '+') END AS pair
    FROM
        main_table a
    JOIN main_table b ON a.order_id = b.order_id AND a.name != b.name
) t
GROUP BY pair
ORDER BY count_pair DESC, pair;
