SELECT product_id,
       name,
       price,
       ROW_NUMBER() OVER (ORDER BY price DESC) AS product_number,
       RANK() OVER (ORDER BY price DESC) AS product_rank,
       DENSE_RANK() OVER (ORDER BY price DESC) AS product_dense_rank
FROM   products;
