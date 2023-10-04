select * from walmartsalesdata;

/*How many unique product lines does the data have?*/
select distinct city from walmartsalesdata;

/*In which city is each branch?*/
select city,branch from walmartsalesdata 
group by city,branch;

-- Product

-- we change column  name 
ALTER TABLE walmartsalesdata CHANGE `Product line` Product_line VARCHAR(100);
-- How many unique product lines does the data have?
select count(distinct Product_line) from walmartsalesdata;

-- What is the most common payment method?
select payment,count(payment) from walmartsalesdata
group by payment;

select branch from walmartsalesdata
where branch is null

-- What is the most selling product line?
select product_line,count(Product_line) cnt from walmartsalesdata
group by product_line
order by  cnt desc;

-- What is the total revenue by month?
select monthname(date) as month,round(sum(total),4) as total_revenue from walmartsalesdata
group by month
order by total_revenue desc;

-- What month had the largest COGS?
select monthname(date) as month,round(sum(cogs),4) as cogs_revenue from walmartsalesdata
group by month
order by cogs_revenue desc;

-- What product line had the largest revenue?
select product_line,round(sum(total),2) as total_revenue from walmartsalesdata
group by product_line
order by total_revenue desc;

-- What is the city with the largest revenue?
select city,round(sum(total),2) as total_revenue from walmartsalesdata
group by city
order by total_revenue desc;

-- What product line had the largest VAT?
select product_line,round(sum(5/100 * `cogs`),2) as vat from walmartsalesdata
group by product_line
order by vat desc;

-- Fetch each product line and add a column to those 
-- product line showing "Good", "Bad". Good if its greater 
-- than average sales

select product_line,
case when total > avg(total) then 

-- Which branch sold more 
-- products than average product sold?
select branch,sum(quantity) as products_sold from walmartsalesdata
group by branch
having sum(quantity)>avg(quantity);

-- What is the most common product line by gender?
select gender,product_line,count(gender) as gender_count
from walmartsalesdata 
group by gender,product_line
order by gender_count desc;

-- What is the average rating of each product line?
select product_line ,round(avg(rating),2) from walmartsalesdata
group by product_line;


-- sales
select * from walmartsalesdata;
select time,
case
when `time` between "00:00:00" and "12:00:00" then "morning"
when 'time' between "12:01:00" and "16:00:00" then "afternoon"
else "evening" end as x
from walmartsalesdata;

alter table walmartsalesdata add column time_of_day varchar(20);

update walmartsalesdata
set time_of_day=(
case
when `time` between "00:00:00" and "12:00:00" then "morning"
when `time` between "12:01:00" and "16:00:00" then "afternoon"
else "evening" end
);
-- adding dayname
select dayname(date) from walmartsalesdata;
alter table walmartsalesdata add column day_name varchar(20);
update walmartsalesdata 
set day_name = dayname(date);
-- adding month name
select monthname(date) from walmartsalesdata;
alter table walmartsalesdata add column month_name varchar(20);
update walmartsalesdata 
set month_name = monthname(date);

select * from walmartsalesdata;
 
-- Number of sales
-- made in each time of the day per weekday

select * from walmartsalesdata;
commit;
delete from walmartsalesdata
where quantity is null;

select time_of_day,count(quantity) from walmartsalesdata
-- where day_name='sunday'
group by time_of_day
order by count(quantity) desc;

-- Which of the customer types brings the most revenue?
select `customer type`,round(sum(total),2) as revenue from walmartsalesdata
group by `Customer type`;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select * from walmartsalesdata;

alter table walmartsalesdata change `Tax 5%` tax_pct decimal(6,4);

select city,round(sum(tax_pct/(0.05 * cogs)),2) as tax_percent from walmartsalesdata 
group by city
order by tax_percent desc;

-- Which customer type pays the most in VAT?
select `customer type`,round(sum(0.05*cogs),2) as vat from walmartsalesdata
group by `Customer type`;

-- How many unique customer types does the data have?
select distinct `customer type` from walmartsalesdata;

select * from walmartsalesdata
-- How many unique payment methods does the data have?
select distinct `Payment` from walmartsalesdata;

-- What is the most common customer type?
select `customer type`,count(`customer type`) from walmartsalesdata
group by `customer type`;

-- What is the gender of most of the customers?
select gender,count(gender) from walmartsalesdata
group by Gender;

-- What is the gender distribution per branch?
select branch,count(gender) from walmartsalesdata
group by branch;

-- Which time of the day do customers give most ratings?
select time_of_day,round(avg(rating),2) as rating from walmartsalesdata
group by time_of_day
order by rating desc;

-- Which time of the day do customers give most ratings per branch?
select time_of_day,branch,round(avg(rating),2) as rating from walmartsalesdata
group by time_of_day,branch
order by rating desc;

-- Which day fo the week has the best avg ratings?
select dayofweek(date) as `dayofweek`,dayname(date) as day_name,
round(avg(rating),2) as avg_rating from walmartsalesdata
group by dayofweek(date),dayname(date) 
order by avg_rating desc ;

-- Which day of the week has the best average ratings per branch?
select branch,dayname(date) as day_name,
round(avg(rating),2) as avg_rating from walmartsalesdata
group by branch,dayname(date) 
order by avg_rating desc;

