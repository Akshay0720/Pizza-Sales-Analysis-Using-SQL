-- Qestion set

select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;


-- Q1.Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders; 


-- Q2.Calculate the total revenue generated from pizza sales.

SELECT 
    round(SUM(order_details.quantity * pizzas.price),2)  AS Total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    
    
-- Q3. Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Q4.Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS total_orders
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY total_orders DESC;


-- Q5.List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;


-- Q6.Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- Q7. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(time) AS hours, COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY hours; 


-- Q8.Join relevant tables to find the category-wise distribution of pizzas.
select * from pizza_types;

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Q9.the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) as Avg_pizzas_order_per_Day
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS order_quantity;
    
-- Q10. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name AS pizza_name,
    SUM(order_details.quantity * pizzas.price) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_name
ORDER BY Revenue DESC
LIMIT 3;


-- Q11.Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category AS category,
    round(SUM(order_details.quantity * pizzas.price) / (select round(SUM(order_details.quantity * pizzas.price)
    ,2) as total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id) *100,2) as revenue
        from pizza_types JOIN pizzas
        on pizza_types.pizza_type_id = pizzas.pizza_type_id
        join order_details on order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY Revenue DESC;


-- Q12. find the total No of Quantitys

select sum(quantity) from order_details;

-- Q13. find the total revenue generated through the pizza category and size.

select pizza_types.category as category,pizzas.size as size,round(sum(order_details.quantity * pizzas.price),2) as revenue
 from 
pizzas join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by category,size;