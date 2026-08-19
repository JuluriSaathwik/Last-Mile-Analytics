Create database QuickRoute;

Use QuickRoute;

create table customers(
	customer_id varchar(20) primary key,
    customer_name  varchar(20) not null,
    city varchar(50) not null,
    delivery_zone_id varchar(10) not null,
    preferred_time_slot varchar(30) default 'Any',
    customer_type varchar(20) default 'Individual',
    account_since Date,
    key(delivery_zone_id)
    );

create table orders(
	order_id varchar(20) primary key,
    customer_id varchar(20),
    order_date date,
    package_weight_kg decimal(5,2) not null,
    delivery_zone_id varchar(10),
    service_type varchar(20) not null,
    priority varchar(10) not null default 'Normal',
    total_value decimal(10,2) not null,
    foreign key(delivery_zone_id) references customers(delivery_zone_id),
    foreign key(customer_id) references customers(customer_id)
    );
    
create table drivers(
	driver_id varchar(10) primary key,
    driver_name varchar(100) not null,
    hire_date date not null,
    rating decimal(3,2) not null default '5.0',
    employment_type varchar(20) not null,
    is_active varchar(3) not null default 'yes'
    );
    
create table vehicles(
	vehicle_id varchar(10) primary key,
    vehicle_type varchar(20) not null default 'Motorbike',
    fuel_type varchar(20) not null default 'Petrol',
    max_payload_kg decimal(7,2) not null,
    depot varchar(10) not null,
    last_service_date date not null,
    is_active varchar(3) not null
    );
    
create table deliveries(
	delivery_id varchar(20) primary key,
    order_id varchar(20),
    driver_id varchar(10),
    vehicle_id varchar(20),
    assigned_date date not null,
    actual_delivery_date date default null,
    status varchar(20) not null,
    delivery_attempt tinyint default 1,
    distance_km decimal(6,2) not null,
    delivery_duration_min int not null,
    foreign key(order_id) references orders(order_id),
    foreign key(driver_id) references drivers(driver_id),
    foreign key(vehicle_id) references vehicles(vehicle_id)
    );
    
-- Verify whether the imported data.

select count(*) from customers;
select * from customers;

select count(*) from orders;
select * from orders;

select count(*) from deliveries;
select * from deliveries;

select count(*) from drivers;
select * from drivers;

select count(*) from vehicles;
select * from vehicles;
