-- Sprint 3: Basic Analysis / Data Exploration
-- 1. What is the total number of customers?
select count(*) from customers;

-- 2. What is the total number of orders?
select count(*) from orders;

-- 3.What is the total number of deliveries?
select count(*) from deliveries;

-- 4.What are the different service types available?
select distinct service_type from orders;

-- 5.How many drivers are currently active?
select count(*) from drivers where is_active = 'yes';

-- 6. What are the different vehicle types?
select distinct vehicle_type from vehicles;

-- 7. What is the total order value?
select sum(total_value) from orders;

-- 8. What is the average package weight? 
select avg(package_weight_kg) from orders;
