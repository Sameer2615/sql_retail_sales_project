select * from retail_sales;

--How many unique customers we have
select count(Distinct customer_id) from retail_sales

--Data Analysis
-- Q.N.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

--Q.N.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category = 'Clothing'
 AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
 AND quantiy >=4

--Q.N.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,SUM(total_sale) As total_sales 
FROM retail_sales
GROUP BY category;

--Q.N.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT category ,ROUND(AVG(age),2) AS avg_age 
FROM retail_sales
WHERE category='Beauty'
GROUP BY category;

--Q.N.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale>1000;

--Q.N.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender,
       category,
	   COUNT(*) as TOTAL_TRANSACTION
FROM retail_sales
GROUP BY gender,category;


---Q.N.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
       year,
	   month,
	   avg_sale
FROM (
SELECT 
      EXTRACT(YEAR FROM sale_date) as year,
	  EXTRACT(MONTH FROM sale_date) as month,
	  AVG(total_sale) as avg_sale,
	  RANK() OVER(PARTITiON BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank=1;

---Q.N.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id,
       SUM(total_sale) AS total_saleS
FROM retail_sales
GROUP BY customer_id
order by 2 DESC
LIMIT 5;

--Q.N.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
       COUNT(DISTINCT(customer_id)) as customer_id
FROM retail_sales
GROUP BY category;

--Q.N.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT  *,
       CASE
	   WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'Evening'
	   END AS shift
FROM retail_sales
)
SELECT 
      shift,
	  COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;



