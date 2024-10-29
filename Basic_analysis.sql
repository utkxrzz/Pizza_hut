SELECT * FROM Pizzahut.orders;
ALTER TABLE Pizzahut.orders
MODIFY date date;
ALTER TABLE Pizzahut.orders
MODIFY time time;
use Pizzahut;
-- Now since we have imported the data for pizzahut outlet, following are the set of problems that we are going to solve

-- Q1. Retrieve the total number of orders placed.
select count(order_id)
from orders;

-- Q2. Calculate the total revenue generated from pizza sales.
select round(sum(price*quantity)) from order_details
join pizzas 
on pizzas.pizza_id = order_details.pizza_id;

-- Q3. Identify the highest-priced pizza.
select name, price from pizzas
join pizza_types 
on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by price desc limit 1;

-- Q4. Identify the most common pizza size ordered.
select size, count(*) from pizzas
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by size order by count(*) desc limit 1;

-- Q5. List the top 5 most ordered pizza types along with their quantities.
select name, count(*) from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by name order by count(*) desc limit 5;














