-- sql retail sales analysis

create database project_1;
use project_1;
create table retail_sales(
          transactions_id INT PRIMARY KEY,
		  sale_date DATE,
		  sale_time TIME,
		  customer_id INT,
		  gender VARCHAR(15),
		  age INT,
		  category VARCHAR,
		  quantiy INT,
		  price_per_unit FLOAT,
		  cogs FLOAT,
		  total_sale FLOAT
 );

 select * from retail_sales; 
 select * from [Retail Sales Analysis];

 drop table retail_sales;
-- counting total numbers of rows

--DATA CLEANING

select count(*) from [Retail Sales Analysis];

-- finding null values

select * from [Retail Sales Analysis] where transactions_id is null;

-- checking all columns in one steps

select * from [Retail Sales Analysis]
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- deleting null ross in one go
delete from [Retail Sales Analysis]
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;


--DATA EXPLORATION
-- FINING TOTAL SALES

select count(transactions_id) from [Retail Sales Analysis]

-- now checking how many uniuqe customers we have

select count (distinct(customer_id)) from [Retail Sales Analysis]

-- seeing all category

select distinct category from [Retail Sales Analysis]

-- write a sql query to retrive the all columns for sales made on 2022-11-05;

select * from [Retail Sales Analysis]
where sale_date = '2022-11-05'

-- write a sql query to retrive the all columns for where category is clothing and quntity 
--sold is more then 3;

select * from [Retail Sales Analysis]
where category = 'clothing' and quantiy >=3

-- calculate the total sale of each columns?

select category,sum(total_sale) as netsale,
count(*) as net_order
from [Retail Sales Analysis]
group by category

--average age of customers who purchased who prchased items from beauty category?
-- if we use select round(avg(age),2) it ill give us upto two decimal points .

select avg(age) as average_age from [Retail Sales Analysis]
where category='Beauty'

-- find all the transactions where total_sale is greater then 1000?

select * from [Retail Sales Analysis]

select 
  year(sale_date) as [year],
  month (sale_date) as [month],
  avg (total_sale) as [averg_sale]
  from  [Retail Sales Analysis]
  group by sale_date
  order by year
  
-- find top five customers based on highest total sale?


select * from [Retail Sales Analysis]
 
select customer_id,
sum(total_sale) as net_sale
from [Retail Sales Analysis]
group by customer_id
order by net_sale desc

-- find unique customers ho purchased from each category??

select 
	customer_id,
	category
	from [Retail Sales Analysis]
	group by category;


select count(distinct(
customer_id) )from [Retail Sales Analysis]

-- create each shift and number of orders ????
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

