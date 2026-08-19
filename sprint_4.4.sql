-- 4.4 Understand Driver and Vehicle Performance
-- 1. Which drivers handle the highest number of deliveries?
select dr.driver_id, count(d.delivery_id) as delivery_count
from drivers dr
left join deliveries d
on dr.driver_id = d.driver_id
group by driver_id
order by delivery_count desc;

-- 2. How do drivers perform across different delivery outcomes?
select dr.driver_id, count(d.delivery_id) as delivery_count,
sum(case when d.status = 'Delivered' then 1 else 0 end) as successful_deliveries,
sum(case when d.status = 'Pending' then 1 else 0 end) as pending_deliveries,
sum(case when d.status = 'Failed' then 1 else 0 end) as failed_deliveries,
sum(case when d.status = 'Rescheduled' then 1 else 0 end) as rescheduled_deliveries
from drivers dr
left join deliveries d
on dr.driver_id = d.driver_id
group by driver_id
order by delivery_count desc;

-- 3. What is the average delivery duration for each driver?
select dr.driver_id, count(d.delivery_id) as total_orders, avg(d.delivery_duration_min) as avg_time
from drivers dr
left join deliveries d
on dr.driver_id = d.driver_id
group by driver_id
order by avg_time desc;

-- 4. How does driver rating relate to delivery performance?
select dr.driver_id, count(d.delivery_id) as total_deliveries,
dr.rating,
sum(case when d.status = 'Delivered' then 1 else 0 end) as success,
sum(case when d.status = 'Failed' then 1 else 0 end) as failure
from drivers dr
left join deliveries d
on dr.driver_id = d.driver_id
group by driver_id
order by rating desc;

-- 5. Which vehicle types are used for the most deliveries?
select v.vehicle_type, count(d.delivery_id) as delivery_count
from vehicles v
left join deliveries d
on v.vehicle_id = d.vehicle_id
group by vehicle_type
order by delivery_count desc;

-- 6. How does delivery performance vary across vehicle types?
select v.vehicle_type, count(d.delivery_id) as delivery_count,
sum(case when d.status = 'Delivered' then 1 else 0 end) as delivered_count,
sum(case when d.status = 'Pending' then 1 else 0 end) as pending_count,
sum(case when d.status = 'Rescheduled' then 1 else 0 end) as rescheduled_count,
sum(case when d.status = 'Failed' then 1 else 0 end) as failed_count
from vehicles v
left join deliveries d
on v.vehicle_id = d.vehicle_id
group by v.vehicle_id
order by delivery_count;

-- 7. Which individual vehicles handle the most deliveries and how do they perform?
select v.vehicle_id,v.vehicle_type,v.fuel_type,
count(d.delivery_id) as delivery_count,
sum(case when d.status = 'Delivered' then 1 else 0 end) as success_count,
sum(case when d.status = 'Failed' then 1 else 0 end) as failed_count,
round(avg(d.delivery_duration_min), 2) as avg_delivery_duration
from vehicles v
join deliveries d
on v.vehicle_id = d.vehicle_id
group by v.vehicle_id,v.vehicle_type,v.fuel_type
order by delivery_count desc;