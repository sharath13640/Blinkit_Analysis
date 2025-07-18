USE blinkitdb;
SELECT * FROM blinkit_data;

-- Data cleaning

UPDATE blinkit_data
SET Item_Fat_Content=
CASE
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END;

SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data;

-- Total Sales
SELECT CAST(SUM(sales)/1000000 as DECIMAL(10,2)) as Total_Sales_Millions
FROM blinkit_data;

-- Average Sales
SELECT CAST(Avg(sales) as DECIMAL(10,1)) as Avg_Sales
FROM blinkit_data;

-- Number of Items
SELECT COUNT(*) AS Number_of_Items FROM blinkit_data;

-- Average Rating
SELECT CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating FROM blinkit_data;

-- Total Sales by Fat Content
SELECT Item_Fat_Content,
	 CAST(SUM(sales)/1000 as DECIMAL(10,2)) as Total_Sales_Thousands,
	 CAST(Avg(sales) as DECIMAL(10,1)) as Avg_Sales,
	 COUNT(*) AS Number_of_Items,
	 CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands ASC;

-- Total Sales by Item Type
SELECT TOP 5 Item_Type,
	 CAST(SUM(sales)/1000 as DECIMAL(10,2)) as Total_Sales_Thousands,
	 CAST(Avg(sales) as DECIMAL(10,1)) as Avg_Sales,
	 COUNT(*) AS Number_of_Items,
	 CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales_Thousands DESC;

-- Fat Content by Outlet for Total Sales
SELECT Outlet_Location_Type,Item_Fat_Content,
	 CAST(SUM(sales)/1000 as DECIMAL(10,2)) as Total_Sales_Thousands,
	 CAST(Avg(sales) as DECIMAL(10,1)) as Avg_Sales,
	 COUNT(*) AS Number_of_Items,
	 CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content,Outlet_Location_Type
ORDER BY Total_Sales_Thousands ASC;

-- Total Sales by Outlet Establishment
SELECT Outlet_Establishment_Year,
	 CAST(SUM(sales) as DECIMAL(10,2)) as Total_Sales,
	 CAST(Avg(sales) as DECIMAL(10,1)) as Avg_Sales,
	 COUNT(*) AS Number_of_Items,
	 CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

-- Percentage of Sales by Outlet Size
SELECT Outlet_Size,
	 CAST(SUM(sales) as DECIMAL(10,2)) as Total_Sales,
	 CAST((SUM(sales)*100/SUM(SUM(sales)) OVER()) as DECIMAL(10,2)) as Total_Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales_Percentage DESC;

-- Sales by Outlet Location
SELECT Outlet_Location_Type,
	 CAST(SUM(sales) as DECIMAL(10,2)) as Total_Sales,
	 CAST((SUM(sales)*100/SUM(SUM(sales)) OVER()) as DECIMAL(10,2)) as Total_Sales_Percentage,
	 CAST(Avg(sales) as DECIMAL(10,1)) as Avg_Sales,
	 COUNT(*) AS Number_of_Items,
	 CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- All Metrics by Outlet Type
SELECT Outlet_Type,
	 CAST(SUM(sales) as DECIMAL(10,2)) as Total_Sales,
	 CAST((SUM(sales)*100/SUM(SUM(sales)) OVER()) as DECIMAL(10,2)) as Total_Sales_Percentage,
	 CAST(Avg(sales) as DECIMAL(10,1)) as Avg_Sales,
	 COUNT(*) AS Number_of_Items,
	 CAST(AVG(rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;