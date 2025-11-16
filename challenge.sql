-- TASK 1 - Top 5 Customers by Total Spend
SELECT c.id, order_id, c.first_name, c.last_name, SUM(oi.quantity * oi.unit_price) AS total_spend 
from customers AS c
JOIN orders AS o ON c.id = o.customer_id
JOIN order_items AS oi ON o.id=oi.order_id
GROUP BY c.id
ORDER BY sum(unit_price) desc
LIMIT 5;

--TASK 2 - Total Revenue by Product Category
SELECT p.category, SUM(oi.quantity * p.price) AS total_revenue
FROM products AS p
JOIN order_items AS oi ON p.id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- TASK 3 - Employees Earning Above Their Department Average
SELECT e.id, e.first_name, e.last_name, e.salary, d.name, 
    (SELECT AVG(salary) 
     FROM employees 
     WHERE department_id = e.department_id) AS department_avg
FROM employees AS e
JOIN departments AS d ON e.department_id = d.id
WHERE e.salary > (SELECT AVG(salary) 
                FROM employees
                WHERE department_id = e.department_id)
ORDER BY d.name, e.salary DESC;

-- TASK 4 - Cities with the Most Loyal Customers
SELECT city, COUNT(DISTINCT c.id) AS loyal_customers
FROM customers AS c
JOIN orders AS o ON c.id = o.customer_id
WHERE c.loyalty_level = 'Gold'
GROUP BY c.city
ORDER BY loyal_customers DESC, city ASC;
