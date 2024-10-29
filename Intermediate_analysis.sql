use Pizzahut;
-- Q1. Join the necessary tables to find the total quantity of each pizza category ordered.
select category, count(*) from order_details od
join pizzas p on od.pizza_id = p.pizza_id
join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pt.category;

-- Q2. Determine the distribution of orders by hour of the day.
select hour(time) as hourly_basis , count(*) from orders
group by hourly_basis order by hourly_basis asc;

-- Q3. Find the category-wise distribution of pizzas.
select category, count(*) from pizza_types
group by category;


-- Q4. Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(orders_per_day)from (
select date, sum(quantity) as orders_per_day from order_details od
join orders o on od.order_id = o.order_id
group by date) t1;


-- Q5. Determine the top 3 most ordered pizza types based on revenue.
select pt.pizza_type_id, sum(price*quantity) as total from pizzas p
join order_details od on p.pizza_id = od.pizza_id
join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by pizza_type_id order by total desc limit 3;