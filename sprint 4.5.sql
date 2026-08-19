-- Sprint 4.5 
-- How many deliveries required multiple attempts?
select count(*) as multiple_delivery_attempts
from deliveries
where delivery_attempt > 1;

-- 2. What is the distribution of delivery attempts?
select delivery_attempt, count(*) as count_delivery_attempts
from deliveries
group by delivery_attempt;

-- 3. What are the most common delivery problem statuses?
select status, count(*) as problem_count
from deliveries
where status in ('Failed','pending','rescheduled')
group by status;

-- 4. Do multiple-attempt deliveries take longer?
select case when delivery_attempt = 1 then 'Single Attempt' else 'Multiple Attempt' end as attempts_count,
count(delivery_id) as deliveries_count,
avg(delivery_duration_min) as avg_time
from deliveries
group by attempts_count;

-- 5. Do multiple-attempt deliveries have different delivery outcomes?
select case when delivery_attempt = 1 then 'Single Attempt' else 'Multiple Attempt' end as attempts_count,
count(delivery_id) as deliveries_count,
status
from deliveries
group by attempts_count,status
order by attempts_count, deliveries_count desc;

-- 6. Which delivery zones experience the most delivery problems?
select o.delivery_zone_id, count(d.delivery_id) as delivery_count,
sum( case when d.status in ('Failed','Pending','Rescheduled') then 1 else 0 end) as problem_count,
round(sum(case when d.status in ('Failed', 'Pending', 'Rescheduled') then 1 else 0 end)*100.0 / COUNT(d.delivery_id),2) as problem_rate
from orders o
inner join deliveries d
group by o.delivery_zone_id
order by problem_rate desc;

-- 7. Are longer-distance deliveries more likely to require multiple attempts?
select 
	case
		when distance_km < 5 then 'under 5km'
        when distance_km < 10 then '5 - 10km'
        when distance_km < 20 then '10 - 20km'
        else 'above 20km'
	end as distance_category,
    count(*) as delivery_count,
    round(avg(delivery_attempt),2) as avg_attempts,
    sum(case when delivery_attempt > 1 then 1 else 0 end) as multiple_delivery_attempt
from deliveries
group by
		case when distance_km < 5 then 'under 5km'
        when distance_km < 10 then '5 - 10km'
        when distance_km < 20 then '10 - 20km'
        else 'above 20km'
end
order by avg_attempts desc;	
    
        