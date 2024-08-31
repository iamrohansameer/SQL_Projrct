-- Q1. Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id)
FROM
    pizzahut.orders;


-- Q2. Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Total_Revenue
FROM
    pizzahut.pizzas
        JOIN
    pizzahut.order_details ON order_details.pizza_id = pizzas.pizza_id
    
    -- Q3. Identify the highest-priced pizza

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Q4. Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzahut.pizzas 
        JOIN
    pizzahut.order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- Q5 List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizzahut.pizza_types
        JOIN
    pizzahut.pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    pizzahut.order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- Q6 Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS Total_quantity
FROM
    pizzahut.pizza_types
        JOIN
    pizzahut.pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    pizzahut.order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Total_quantity DESC;

-- Q7 Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(time) AS Hour, COUNT(order_id) AS Order_count
FROM
    pizzahut.orders
GROUP BY HOUR(time);

-- Q8 Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Q9. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(Quantity), 0)
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS Quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS order_quantity
    
    
    -- Q10. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Total_Revenue
FROM
    pizzahut.pizzas
        JOIN
    pizzahut.pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    pizzahut.order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Total_Revenue DESC
LIMIT 3;

-- 11. Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS Total_sales
                FROM
                    pizzahut.order_details
                        JOIN
                    pizzahut.pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100,
            2) AS Total_Revenue
FROM
    pizzahut.pizza_types
        JOIN
    pizzahut.pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    pizzahut.order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Total_Revenue DESC;