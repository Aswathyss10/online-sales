CREATE  TABLE Details(Order_ID VARCHAR(10),Amount NUMERIC(10,2),Profit NUMERIC(10,2),Quantity INT,Category VARCHAR(20),Sub_Category VARCHAR(20),PaymentMode VARCHAR(20)	
);
COPY details FROM 'C:\Users\Aswat\Downloads\sales\Details.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE orders(Order_ID VARCHAR(10),Order_Date date ,CustomerName VARCHAR(30),State VARCHAR(50),City VARCHAR(50)
);
COPY orders FROM 'C:\Users\Aswat\Downloads\sales\Orders.csv'
DELIMITER ',' CSV HEADER;


--count of order
SELECT  DISTINCT count(order_id) FROM "public"."details";

-- extract month from order_date
SELECT EXTRACT( MONTH FROM order_date)  FROM "public"."orders";

--alter and updating month in the table

ALTER TABLE orders ADD order_month INT;

UPDATE orders SET  order_month=EXTRACT( MONTH FROM order_date) ;
SELECT * FROM orders;

--Quantity Sold per Category

SELECT category,sum(quantity) AS total_quantity FROM "public"."details" GROUP BY category ORDER BY total_quantity DESC;

--product wth there profit

SELECT category,sum(profit) AS total_profit  FROM "public"."details" GROUP BY category ORDER BY total_profit DESC;

--product with highest ren
SELECT category,sum(amount) AS total_ren FROM details GROUP BY category ORDER BY total_ren DESC;

--highest sales based on the sub category
SELECT sub_category, sum(amount) AS total_ren FROM details GROUP BY sub_category ORDER BY sum(amount) DESC;

--Most Popular Payment Mode 
SELECT paymentmode,count(*) AS total_pay FROM "public"."details" GROUP BY paymentmode ORDER BY total_pay DESC;

--Transaction Count by Sub-Category and Payment Mode
SELECT sub_category, paymentmode,count(*) AS total_pay FROM "public"."details" GROUP BY sub_category, paymentmode ORDER BY total_pay DESC;

--Monthly Revenue Trend
SELECT o.order_month, sum(d.amount) AS total_ren FROM "public"."orders" AS o JOIN details AS d USING (order_id)GROUP BY o.order_month ORDER BY o.order_month  ASC ;

--highest sales based on state
SELECT o.state,sum(d.amount) AS highest_sale_based_on_state FROM "public"."orders" AS o JOIN details AS d USING (order_id)GROUP BY o.state ORDER BY
highest_sale_based_on_state DESC;

--highest sales based on city

SELECT o.city,sum(d.amount) AS highest_sale_based_on_city FROM "public"."orders" AS o JOIN details AS d USING (order_id)GROUP BY o.city ORDER BY
highest_sale_based_on_city DESC;

--Average Profit per Order

SELECT avg(profit)AS avg_profit FROM "public"."details";

-- Top 5 Customers by Total Purchase

SELECT customername,sum(amount) FROM "public"."orders" AS o JOIN details AS d USING(order_id) GROUP BY customername ORDER BY sum(amount) DESC LIMIT 5;

--Limit to a Date Range

SELECT o.order_date,sum(d.profit) AS total_profit FROM "public"."orders" AS o JOIN  "public"."details" AS d USING(order_id) WHERE o.order_date BETWEEN '2018-01-01' AND '2018-06-30' GROUP BY o.order_date ORDER BY o.order_date;



