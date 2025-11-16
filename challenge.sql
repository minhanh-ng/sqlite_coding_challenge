-- TASK 1 - Top 5 Customers by Total Spend
-- Using JOIN to combine tables, GROUP BY to aggregate spend per customer, ORDER BY to sort by total spend, and LIMIT to get top 5.
SELECT c.id, order_id, c.first_name, c.last_name, SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers AS c
JOIN orders AS o ON c.id = o.customer_id
JOIN order_items AS oi ON o.id = oi.order_id
GROUP BY c.id
ORDER BY total_spend DESC
LIMIT 5;

--TASK 2 - Total Revenue by Product Category  
-- Using JOIN to combine product and order item tables, GROUP BY to aggregate revenue per category, and ORDER BY to sort by total revenue.
SELECT p.category, SUM(oi.quantity * p.price) AS total_revenue
FROM products AS p
JOIN order_items AS oi ON p.id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- TASK 3 - Employees Earning Above Their Department Average
-- Using JOIN to combine employee and department tables, subquery to calculate department average salary, and WHERE clause to filter employees earning above average.
SELECT e.id, e.first_name, e.last_name, e.salary, d.name AS department_name, 
    (SELECT AVG(salary) 
     FROM employees 
     WHERE department_id = e.department_id) AS department_avg
FROM employees AS e
JOIN departments AS d ON e.department_id = d.id
WHERE e.salary > (SELECT AVG(salary) 
                FROM employees
                WHERE department_id = e.department_id)
ORDER BY department_name, e.salary DESC;

-- TASK 4 - Cities with the Most Loyal Customers
-- Using JOIN to combine customer and order tables, WHERE clause to filter loyal customers, GROUP BY to aggregate by city, and ORDER BY to sort by number of loyal customers.
SELECT city, COUNT(DISTINCT c.id) AS loyal_customers
FROM customers AS c
JOIN orders AS o ON c.id = o.customer_id
WHERE c.loyalty_level = 'Gold'
GROUP BY c.city
ORDER BY loyal_customers DESC, city ASC;
