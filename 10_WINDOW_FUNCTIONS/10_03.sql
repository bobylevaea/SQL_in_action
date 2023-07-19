SELECT product_id,
       name,
       price,
       MAX(price) OVER (ORDER BY price DESC) AS max_price,
       MIN(price) OVER (ORDER BY price DESC) AS min_price
FROM   products
ORDER BY price DESC, product_id;
