-- No order references (should be 0)
SELECT COUNT(*) FROM Customer_orders_realistic o LEFT JOIN Drivers_realistic d USING (DriverID) WHERE d.DriverID IS NULL;
SELECT COUNT(*) FROM Customer_orders_realistic o LEFT JOIN Restaurants_realistic r USING (RestaurantID) WHERE r.RestaurantID IS NULL;
SELECT COUNT(*) FROM Customer_orders_realistic o LEFT JOIN Traffic_data_realistic t USING (LocationID) WHERE t.LocationID IS NULL;

 
SELECT DISTINCT OrderStatus
FROM Customer_orders_realistic
ORDER BY OrderStatus;


-- Orders referencing missing drivers
SELECT COUNT(*) AS missing_drivers
FROM Customer_orders_realistic o
LEFT JOIN Drivers_realistic d ON o.DriverID = d.DriverID
WHERE d.DriverID IS NULL;

-- Orders referencing missing restaurants
SELECT COUNT(*) AS missing_restaurants
FROM Customer_orders_realistic o
LEFT JOIN Restaurants_realistic r ON o.RestaurantID = r.RestaurantID
WHERE r.RestaurantID IS NULL;



-- Orders referencing missing locations
SELECT COUNT(*) AS missing_locations
FROM Customer_orders_realistic o
LEFT JOIN Traffic_data_realistic t ON o.LocationID = t.LocationID
WHERE t.LocationID IS NULL;


select * from
customer_orders_realistic ;


SELECT COUNT(*) FILTER (WHERE deliveryhours IS NULL OR deliveryhours = 0) AS missing_or_zero
FROM customer_orders_realistic;


select * from
customer_orders_realistic ;



SELECT column_name, data_type, udt_name, is_nullable,
       numeric_precision, numeric_scale, datetime_precision
FROM information_schema.columns
WHERE table_schema = 'public'           -- change if not public
  AND table_name  = 'customer_orders_realistic'
  AND column_name IN ('ordertimestamp','deliverytime','timetakentodeliver','deliveryhours','orderstatus');


SELECT
  COUNT(*)                                  AS rows_with_hours,
  MIN(deliveryhours)                         AS min_hours,
  MAX(deliveryhours)                         AS max_hours,
  AVG(deliveryhours)                         AS avg_hours,
  COUNT(*) FILTER (WHERE deliveryhours = 0)  AS zero_hours
FROM public.customer_orders_realistic
WHERE deliveryhours IS NOT NULL;



select * from
customer_orders_realistic ;



SELECT COUNT(*) AS rows_to_update,
       MIN(ordertimestamp) AS min_order_ts,
       MAX(ordertimestamp) AS max_order_ts
FROM customer_orders_realistic
WHERE deliverytime IS NULL
  AND timetakentodeliver IS NULL
  AND deliveryhours IS NOT NULL
  AND deliveryhours > 0;



SELECT
  COUNT(*) FILTER (WHERE deliverytime IS NULL)        AS deliverytime_null,
  COUNT(*) FILTER (WHERE timetakentodeliver IS NULL)  AS time_taken_null
FROM public.customer_orders_realistic;



-- perform the update
UPDATE public.customer_orders_realistic
SET
  timetakentodeliver = (deliveryhours * INTERVAL '1 hour')::time,
  deliverytime        = ordertimestamp + deliveryhours * INTERVAL '1 hour'
WHERE deliverytime IS NULL
  AND timetakentodeliver IS NULL
  AND deliveryhours IS NOT NULL
  AND deliveryhours > 0;



-- perform the update
UPDATE public.customer_orders_realistic
SET
  timetakentodeliver = (deliveryhours * INTERVAL '1 hour')::time,
  deliverytime        = ordertimestamp + deliveryhours * INTERVAL '1 hour'
WHERE deliverytime IS NULL
  AND timetakentodeliver IS NULL
  AND deliveryhours IS NOT NULL
  AND deliveryhours > 0;


SELECT
  COUNT(*) FILTER (WHERE deliverytime IS NULL)        AS deliverytime_null,
  COUNT(*) FILTER (WHERE timetakentodeliver IS NULL)  AS time_taken_null
FROM public.customer_orders_realistic;

select * from
customer_orders_realistic ;




