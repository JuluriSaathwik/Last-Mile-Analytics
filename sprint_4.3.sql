-- 4.3 Evaluate Delivery Performance
-- 1. What is the distribution of delivery statuses?
select status, count(*) as count_status
from deliveries
join orders
on deliveries.order_id = orders.order_id
group by status
order by count_status desc;

-- 2. How does delivery performance vary across delivery zones?
select o.delivery_zone_id as delivery_zone_id,
count(d.delivery_id) as delivery_count,
sum(case when d.status = 'Delivered' then 1 else 0 end) as total_delivery,
sum(case when d.status = 'Rescheduled' then 1 else 0 end) as total_reschedule,
sum(case when d.status = 'Pending' then 1 else 0 end) as total_pending,
sum( case when d.status = 'Failed' then 1 else 0 end) as total_failed
from orders o
join deliveries d
on o.order_id = d.order_id
group by delivery_zone_id
order by delivery_count desc;

-- 3. What is the average delivery duration by zone?
select o.delivery_zone_id, count(d.delivery_id) as delivery_count, avg(d.delivery_duration_min) as avg_time
from orders o
join deliveries d
on o.order_id = d.order_id
group by delivery_zone_id
order by avg_time desc;

-- 4. How do delivery outcomes differ across service types?
select o.service_type,
count(d.delivery_id) AS delivery_count,
sum(CASE WHEN d.status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_count,
sum(CASE WHEN d.status = 'Failed' THEN 1 ELSE 0 END) AS failed_count,
sum(CASE WHEN d.status = 'Pending' THEN 1 ELSE 0 END) AS pending_count,
sum(CASE WHEN d.status = 'Rescheduled' THEN 1 ELSE 0 END) AS rescheduled_count
from orders o
join deliveries d
on o.order_id = d.order_id
group by o.service_type
order by delivery_count desc;

-- 5. How does delivery duration vary by service type?
select o.service_type,
count(d.delivery_id) as order_count,
min(d.delivery_duration_min) as min_delivery_duration,
max(d.delivery_duration_min) as max_delivery_duration,
avg(d.delivery_duration_min) as avg_delivery_duration
from orders o
join deliveries d
on o.order_id = d.order_id
group by service_type
order by avg_delivery_duration desc;

-- 6. Which zones have higher delivery activity or poorer outcomes?
select o.delivery_zone_id,
count(d.delivery_id) as delivery_count,
sum(case when d.status = 'Failed' then 1 else 0 end) as failure_count,
round(sum(case when d.status = 'Failed' then 1 else 0 end)/count(d.delivery_id)*100,2) as failure_percent
from orders o
join deliveries d
group by o.delivery_zone_id
order by failure_percent desc;

-- 7. How does delivery performance change over time?
select date_format(d.assigned_date,'%Y-%M') as months,
count(d.delivery_id) as total_delivey_count,
sum(case when d.status = 'Delivered' then 1 else 0 end) as delivered_count,
sum(case when d.status = 'Pending' then 1 else 0 end) as pending_count,
sum(case when d.status = 'Failed' then 1 else 0 end) as failed_count,
sum(case when d.status = 'Rescheduled' then 1 else 0 end) as rescheduled_count,
round(avg(delivery_duration_min)) as avg_time
from deliveries d
group by months
order by months;