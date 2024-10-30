use Pizzahut;
-- Q1. Calculate the percentage contribution of each pizza type to total revenue.
select pt.category, ((sum(quantity*price)/(select sum(od.quantity*p.price) from order_details od
join pizzas p on p.pizza_id = od.pizza_id
join pizza_types pt on pt.pizza_type_id = p.pizza_type_id))*100) as revenue from order_details od
join pizzas p on p.pizza_id = od.pizza_id
join pizza_types pt on pt.pizza_type_id = p.pizza_type_id
group by category;


-- Q2. Analyze the cumulative revenue generated over time.
select order_date,
sum(revenue) over(order by order_date) as cum_revenue from (select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;



-- Q3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name, revenue from (select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category, pizza_types.name, sum((order_details.quantity) * pizzas.price) as revenue from pizza_types join pizzas
on pizza_types-pizza_type_id = pizzas.pizza_type_id
join order_details
I
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b where rn <= 3;