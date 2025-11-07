--Create retail_sales Table 

Create Table retail_sales 
	(
		transactions_id Int Primary key,
		sale_date Date,
		sale_time Time,
		customer_id INT,
		gender Varchar(15) ,
		age INT,
		category Varchar(15),
		quantiy Int,
		price_per_unit Float,
		cogs	Float,
		total_sale  Float
	);

	select * from retail_sales;

	select Count(*)
	from retail_sales;

	
-- Data Cleaning

	select * from retail_sales
	where age is null;

 select * from retail_sales 
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null;

-----Detele Null Values

Delete from retail_sales 
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null;

-- Data Exporation

-- How Many sales We have?

 	select count(*) as Total_sales 
	 from retail_sales;
	 
-- How Many  unique Customers  We have?

 	select count( distinct Customer_id) as Total_sales 
	 from retail_sales;


--Data Analysis And Business problemswith Answers
--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
--2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
--3.Write a SQL query to calculate the total sales (total_sale) for each category.:
--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
--8.Write a SQL query to find the top 5 customers based on the highest total sales **:
--9.Write a SQL query to find the number of unique customers who purchased items from each category.:
--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening


--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * 
	from retail_sales
where sale_date = '2022-11-05';

--2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * 
	from retail_sales
where category = 'Clothing'
	And quantiy >= 4 
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
---------------------------------------------------------------------
SELECT 
  *
	FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4;
  
--3.Write a SQL query to calculate the total sales (total_sale) for each category.:

 select category,
	 sum(total_sale) as Net_sale,
	 count(*) as Total_Orders
	 from retail_sales
 group by 1 ;

----4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select 
	avg(age) as Avg_age
	from retail_sales
where category = 'Beauty';
---------------------------------------------------------------------
SELECT
    ROUND(AVG(age), 2) as avg_age
	FROM retail_sales
WHERE category = 'Beauty';

----5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select *
	from retail_sales
where total_sale > 1000;

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;

--8.Write a SQL query to find the top 5 customers based on the highest total sales **:

select
	customer_id,
	Sum(total_sale) As total_sales 
	from retail_sales
group by 1
order by 2 Desc
limit 5;

--9.Write a SQL query to find the number of unique customers who purchased items from each category.:
select category,
count(distinct Customer_id) as Unique_Csmr
from retail_sales
group by 1;
------------------------------------------------------------
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening
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
GROUP BY shift;

---------------------------------------------DONE---------------------------------------------























