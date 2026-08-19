-- Sprint 4
-- 4.1 Understand Delivery Demand
-- Analytical Questions
-- 1. Which Zones generate the most orders
select delivery_zone_id, count(*) as order_count from orders group by delivery_zone_id order by order_count desc;

-- 2. Which service types are most frequently used by customers?
select service_type, count(*) as order_count from orders group by service_type order by order_count desc;

-- 3. How does order volume vary by priority level?
select priority, count(*) as order_volume from orders group by priority order by order_volume desc;

-- 4. How does monthly order volume change over time?
select date_format(order_date, '%Y-%M') as order_month, count(*) as order_volume from orders group by order_month order by order_month desc;

-- 5. How does yearly order volume change over time?
select date_format(order_date, '%Y') as order_yearly, count(*) as order_volume from orders group by order_yearly order by order_yearly desc;

-- 6. Which delivery zones generate the highest total order value?
select delivery_zone_id, sum(total_value) as total_order_value from orders group by delivery_zone_id order by total_order_value desc;

-- 7. What is the average order value across different service types?
select service_type, avg(total_value) as avg_order_value from orders group by service_type order by avg_order_value desc;

-- 8. Which delivery zones have both high order volume and high order value?
select delivery_zone_id, count(*) as order_volume, sum(total_value) as order_value , avg(total_value) as avg_order_value
from orders 
group by delivery_zone_id 
order by order_volume desc, order_value desc;
