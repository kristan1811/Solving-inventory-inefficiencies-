#creation of database
create DATABASE inventory_project;
show databases;
use inventory_project;
drop table cleaned_inventory;
select count(*) from inventory_data;
select count(distinct `product id`) from inventory_data;

#retrieving all data
select * from inventory_data;

#calculating total revenue
select sum(revenue) from inventory_data;
#total revenue = 539442283.779491

#calculating revenue category wise
select category,sum(revenue) as revenue_cat from inventory_data group by category order by revenue_cat desc;
#clothing has highest revenue followed by electronice and furniture

#calculating catefory wise sales
select category, sum(`units sold`) as total_sales from 
inventory_data group by category order by total_sales desc;
#clothing has highest sales followed by electronice and furniture

#identifying top selling products
select `Product ID`, sum(`Units Sold`) as total_sales from inventory_data group by `Product ID`
order by total_sales desc;
#1.p0057-387209
#2.P0046-386805
#3.P0133-385843

#calaculating region wise sales
select region, sum(`units sold`) as total_sales from
inventory_data group by region order by total_sales desc;
#1.east 2.west 3.north 4.south

#calculating region wise revenue
select region, sum(`revenue`) as total_sales from
inventory_data group by region order by total_sales desc;
#1.east 2.west 3.north 4.south

#store performace
select `store id`, sum(revenue) as total_revenue from inventory_data
group by `store id` order by total_revenue desc;
#1.s005 2.s004 3.s001

#store sales
select `store id`, sum(`units sold`) as total_sales from inventory_data
group by `store id` order by total_sales desc;
#1.s005 2.s003 3.s004

#low inventory detection
select `product id`,avg(`inventory level`) as average_inventory
from inventory_data group by `product id` having average_inventory<50;

# Seasonal sales analysis
select seasonality , sum(`units sold`) as total_sales 
from inventory_data group by seasonality order by total_sales desc;
select seasonality , sum(`revenue`) as total_sales 
from inventory_data group by seasonality order by total_sales desc;
#winter has high sales

#promotion impact
select `holiday/promotion`, avg(`units sold`) as avg_sales
from inventory_data group by `holiday/promotion`;
#promotion has a good impact on saless

#weather impact
select `Weather Condition`, avg(`units sold`) as avg_sales
from inventory_data group by `Weather Condition`;
#weather doesnt impact much on sales


#calculation of inventory movement ratio
#inventory movement ratio = Units Sold/Average inventory

select `product id`,sum(`units sold`) as total_units_sold,
sum(`inventory level`) as total_inventory_level,
 sum(`units sold`)/sum(`inventory level`) as inventory_movement_ratio 
from inventory_data group by `product id` order by inventory_movement_ratio desc;

#ABC analysis (80-20 rule)
select `product id`, sum(revenue) as revenue
from inventory_data group by `product id`order by revenue desc;
#1.P0066 2.P0061 3.P0133

#forecast error
select `product id` , avg(`units sold`) as avg_sales, avg(`demand forecast`) as avg_forecast,
avg(`units sold`)-avg(`demand forecast`) as forecast_error
from inventory_data
group by `product id`;
#positive - actual sales exceeded forecast
#negative - forecast overestimated demand

#reorder analysis
SELECT `Product ID`,AVG(`Inventory Level`) AS avg_inventory,
(AVG(`Demand Forecast`) * 7+ 20) AS reorder_point
FROM inventory_data
GROUP BY `Product ID`
HAVING avg_inventory < reorder_point;
#these return products needing replenishment

