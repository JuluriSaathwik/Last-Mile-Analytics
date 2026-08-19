-- 4.2 Understand Customer Order Behaviour
-- 1. Which customers place the highest number of orders?
select c.customer_id, c.customer_name, count(o.order_id) as order_count
from customers c
left join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by order_count desc;

-- 2. Which customers generate the highest total order value?
select c.customer_id, c.customer_name, sum(total_value) as total_order_value
from customers c
left join orders o
on c.customer_id = o.customer_id
group by c.customer_id
order by total_order_value desc;

-- 3. Which customers have both high order frequency and high order value ?
select c.customer_id, c.customer_name, count(o.order_id) as order_count, sum(total_value) as total_order_value
from customers c
left join orders o
on c.customer_id = o.customer_id
group by c.customer_id
order by order_count desc, total_order_value desc;

-- 4. How does customer activity vary across delivery zones?
select c.delivery_zone_id, count(distinct c.customer_id) as customer_count, count(order_id) as order_count, sum(total_value) as total_order_value
from customers c
left join orders o
on c.delivery_zone_id = o.delivery_zone_id
group by c.delivery_zone_id
order by order_count desc;

-- 5. How do Business and Individual customers differ in their ordering behaviour?
select c.customer_type, count(distinct c.customer_id) as customer_count, count(o.order_id) as total_orders, sum(o.total_value) as total_order_value,
avg(o.total_value) as avg_order_value
from customers c
join orders o
on c.customer_id = o.customer_id
group by customer_type
order by total_order_value;

-- 6. How does customer ordering activity change over time?
select date_format(order_date, '%Y-%M') as month_orders,
count(*) as order_count,
count(distinct customer_id) as active_customers,
sum(total_value) as total_ordeR_value
from orders
group by month_orders
order by month_orders;

-- 7. What proportion of customers are repeat customers?
select customer_id, count(order_id) as total_orders from orders
group by customer_id
order by total_orders desc;

