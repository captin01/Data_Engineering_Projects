	--Product Performance: 
	--Which items have the highest sales volume 
	
	SELECT
		it.item_name,
		SUM(s.quantity) AS total_quantity_sold
	FROM
		sales s
	JOIN
		item it ON s.item_id = it.item_id
	GROUP BY
		it.item_name
	ORDER BY
		total_quantity_sold DESC
	LIMIT 20;
		
	-- Are there specific products that consistently contribute to a significant portion of the total revenue?
	
	SELECT
	    it.item_name,
	    SUM(s.total_price) AS total_revenue
	FROM
	    sales s
	JOIN
	    item it ON s.item_id = it.item_id
	GROUP BY
	    it.item_name
	ORDER BY
	    total_revenue DESC
	LIMIT 20;
	
	-- Supplier and Manufacturing Insights: 
	--Are there correlations between the manufacturing country of an item and its sales performance?
	
	SELECT
	    it.man_country,
	    SUM(s.total_price) AS total_sales,
	    ROUND(AVG(s.unit_price),2) AS avg_unit_price
	FROM
	    sales s
	JOIN
	    item it ON s.item_id = it.item_id
	GROUP BY
	    it.man_country
	ORDER BY
	    total_sales DESC;
	
	--Is there a relationship between unit prices and the manufacturer's country?
	
	SELECT
	    it.man_country,
	    AVG(s.unit_price) AS avg_unit_price,
	    SUM(s.quantity) AS total_quantity_sold
	FROM
	    sales s
	JOIN
	    item it ON s.item_id = it.item_id
	GROUP BY
	    it.man_country
	ORDER BY
	    avg_unit_price DESC;
	
	-- How do different stores divisions contribute to the overall revenue?
	
	WITH StoreSales AS (
	    SELECT
	        sd.division,
	        SUM(s.total_price) AS total_sales
	    FROM
	        sales s
	    JOIN
	        store sd ON s.store_id = sd.store_id
	    GROUP BY
	        sd.division
	)
	
	SELECT
	    ss.division,
	    ss.total_sales,
	    ROUND((ss.total_sales / SUM(ss.total_sales) OVER ()) * 100, 2) AS percentage_of_total_sales
	FROM
	    StoreSales ss
	ORDER BY
	    total_sales DESC;
	
	--Time-based Analysis:
	--Are there specific time periods (days, weeks, months) that exhibit higher sales activity?
	
	--Week
	
	SELECT
	    td.week AS sales_week,
	    SUM(s.total_price) AS total_sales
	FROM
	    sales s
	JOIN
	    time td ON s.time_id = td.time_id
	GROUP BY
	    sales_week
	ORDER BY
	    total_sales DESC;
	
	--Month
	
	SELECT
	    td.month AS sales_month,
	    SUM(s.total_price) AS total_sales
	FROM
	    sales s
	JOIN
	    time td ON s.time_id = td.time_id
	GROUP BY
	    sales_month
	ORDER BY
	    total_sales DESC;

	--Quarter
	
	SELECT
	    td.quarter AS sales_quarter,
	    SUM(s.total_price) AS total_sales
	FROM
	    sales s
	JOIN
	    time td ON s.time_id = td.time_id
	GROUP BY
	    sales_quarter
	ORDER BY
	    total_sales DESC;

	--Year
	
	SELECT
	    td.year AS sales_year,
	    SUM(s.total_price) AS total_sales
	FROM
	    sales s
	JOIN
	    time td ON s.time_id = td.time_id
	GROUP BY
	    sales_year
	ORDER BY
	    total_sales DESC;

	--How do customers behave during certain hours of the day?

	SELECT
	    CASE
	        WHEN td.hour BETWEEN 6 AND 12 THEN 'Morning'
	        WHEN td.hour BETWEEN 12 AND 14 THEN 'Midday'
	        WHEN td.hour BETWEEN 14 AND 17 THEN 'Evening'
	        WHEN td.hour BETWEEN 18 AND 23 THEN 'Night'
	        WHEN td.hour BETWEEN 23 AND 0 THEN 'Midnight'
			ELSE 'Ungoldy_hours'
	    END AS time_category,
	    COUNT(*) AS activity_count
	FROM
	    sales s
	JOIN
	    time td ON s.time_id = td.time_id
	GROUP BY
	    time_category
	ORDER BY
	    activity_count DESC;
	
	--Transaction Insights:
	--What are the predominant transaction types, and how do they vary in terms of total sales?
	
	SELECT
	    t.trans_type,
	    COUNT(*) AS transaction_count,
	    SUM(s.total_price) AS total_sales
	FROM
	    sales s
	JOIN
	    transaction t ON s.payment_id = t.payment_id
	GROUP BY
	    t.trans_type
	ORDER BY
	    total_sales DESC;
	
	--Is there a correlation between the choice of bank for transactions and sales performance?
	
	SELECT
	    t.bank_name,
	    COUNT(*) AS transaction_count,
	    SUM(s.total_price) AS total_sales
	FROM
	    sales s
	JOIN
	    transaction t ON s.payment_id = t.payment_id
	GROUP BY
	    t.bank_name
	ORDER BY
    total_sales DESC;
