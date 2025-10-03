# Delivery Performance and Service Reliability in the Food Delivery Sector
# Urban Eats Delivery Performance Analysis

## Table of Contents
- [Project Overview](#project-overview)
- [Problem Statement](#problem-statement)
- [Data Sources](#data-sources)
- [Tools and Skills](#tools-and-skills)
- [Data Preparation](#data-preparation)
- [Data Analysis](#data-analysis)
- [Results / Insights](#results--insights)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [References](#references)
- [Visuals](#visuals)

---

## Project Overview
Urban Eats is a food delivery service where **timeliness and reliability** are critical to customer satisfaction and competitiveness.  

This project evaluates **delivery performance and service reliability** using 1,000 delivery records.  

**Objectives:**
- Measure on-time delivery performance against SLA thresholds.  
- Identify operational inefficiencies (pending orders, late deliveries).  
- Segment performance across drivers, restaurants, and locations.  
- Provide data-driven recommendations to improve customer satisfaction and operational efficiency.  

---

## Problem Statement
The business wanted to understand:  
1. **How reliable are current deliveries compared to SLA targets?**  
2. **Which drivers, restaurants, or delivery zones are contributing to delays?**  
3. **What would happen if SLA targets were adjusted (9, 12, 15 minutes)?**  
4. **What operational improvements can increase on-time performance?**  

---

## Data Sources
The dataset consisted of **1,000 Urban Eats delivery records**, including:  
- Delivery timestamps: order creation, pickup, completion  
- Driver identifiers  
- Restaurant identifiers  
- Customer location zones (proxy for congestion/routing)  
- Order status: on-time, late, pending  

---

## Tools and Skills
- **PostgreSQL** – for data extraction, cleaning, and aggregation  
- **Power BI** – dashboards and interactive reports  
- **DAX** – for calculated measures (on-time %, SLA sensitivity, average delivery time)  

### Sample Code

```sql
-- PostgreSQL: Calculate late deliveries by driver
SELECT driver_id, 
       COUNT(*) FILTER (WHERE status = 'Late') AS late_orders,
       COUNT(*) AS total_orders,
       ROUND((COUNT(*) FILTER (WHERE status = 'Late')::decimal / COUNT(*)) * 100,2) AS late_percentage

```
 Full SQL scripts: [SQL/urban_eats_queries.sql](SQL/urban_eats_queries.sql)  
 Power BI dashboard file (with DAX measures): [PowerBI/UrbanEats_Report.pbix](PowerBI/UrbanEats_Report.pbix)  

---

## Data Preparation
**Steps taken:**
- Removed **nulls, duplicates, and test entries**.  
- Excluded **zero-duration records** that would distort averages.  
- Created calculated fields for:  
  - Delivery duration (minutes)  
  - SLA compliance (met / not met)  
  - Pending vs completed orders  
- Aggregated data by **driver, restaurant, and delivery zone** for deeper analysis.  

---

## Data Analysis
The analysis was structured around key business questions:

1. **What is the current state of delivery performance?**  
   - Measured on-time vs. late deliveries.  
   - Tracked pending orders at different checkpoints.  
   - Calculated average delivery times across all orders.  

2. **Where are the delays occurring?**  
   - Segmented by **driver** to highlight top and low performers.  
   - Segmented by **restaurant** to capture preparation bottlenecks.  
   - Segmented by **location zones** to evaluate congestion and routing issues.  

3. **How do SLA thresholds affect reliability?**  
   - Tested delivery outcomes under **9, 12, and 15-minute SLAs**.  
   - Compared on-time percentages across scenarios.  

4. **What actionable insights can be drawn?**  
   - Benchmarked best-performing drivers.  
   - Identified underperforming restaurants and congested zones.  
   - Recommended SLA targets aligned with operational capacity.  

---

## Results / Insights

### Delivery Performance Overview
- **Total Orders:** 1,000  
- **Delivered Orders:** 35%  
- **Pending Orders:** 65%  
- **On-Time Deliveries (9-min SLA):** 53%  
- **Late Deliveries:** 47%  
- **Average Delivery Time:** 9.32 minutes  

Despite the average delivery time being within SLA, nearly **half of deliveries missed the target**, showing inconsistency.  

---

### Drivers
- Top driver: **Michelle Ballard – 88% on-time (28 completed orders, avg. 9.79 mins)**  
- Most other drivers performed significantly below this benchmark  

### Restaurants
- A few restaurants caused most **pending orders**, indicating prep bottlenecks  

### Locations
- Congested delivery zones showed consistently higher lateness  

### SLA Sensitivity
- **9 mins:** 53% on-time  
- **12 mins:** 65% on-time  
- **15 mins:** 82% on-time  

This demonstrates the **trade-off between customer expectations and operational capacity**.  

---

## Recommendations
- **Replicate best driver practices** to raise fleet performance.  
- **Reduce prep delays** in underperforming restaurants.  
- **Target congested delivery zones** with smarter routing and resource allocation.  
- **Use SLA strategically:**  
  - 9 mins = diagnostic benchmark  
  - 12 mins = balanced, achievable target  
  - 15 mins = risk of masking inefficiencies  

---

## Limitations
- Dataset size: **1,000 orders only** → limited coverage of seasonality.  
- External factors such as **traffic, weather, tim**

FROM deliveries
GROUP BY driver_id;
