SELECT product_id,
       name,
       price,
       MAX(price) OVER() AS max_price,
       ROUND(price / MAX(price) OVER (), 2) AS share_of_max
FROM   products
ORDER BY price DESC, product_id;
