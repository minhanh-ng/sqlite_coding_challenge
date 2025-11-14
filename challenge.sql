-- TASK 1 - Top 5 Customers by Total Spend
SELECT c.id, order_id, c.first_name, c.last_name, SUM(oi.quantity * oi.unit_price) AS total_spend 
from customers AS c
JOIN orders AS o ON c.id = o.customer_id
JOIN order_items AS oi ON o.id=oi.order_id
GROUP BY c.id
ORDER BY sum(unit_price) desc
LIMIT 5;

--TASK 2
SELECT * From customers;