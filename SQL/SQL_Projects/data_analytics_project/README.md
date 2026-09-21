# Data Analytics Project

A SQL-based exploratory and advanced analytics project, built on top of the Gold layer views from my [Data Warehouse Project](../data_warehouse_project), exploring customer, product, and sales data through trend analysis, ranking, segmentation, and consolidated reporting, as part of my data engineering learning journey.

## What's Covered

- **Exploration** — database structure, dimensions, date ranges, key measures
- **Analysis** — magnitude (by country/category/gender), ranking (top/bottom performers), change over time, cumulative totals, year-over-year performance
- **Segmentation** — products by cost range, customers by spending behavior
- **Reporting** — two consolidated views (`gold.report_customer`, `gold.report_products`) combining metrics, segments, and KPIs for repeatable use

## Structure

```
data_analytics_project/
  README.md
  scripts/
    01_database_exploration.sql
    02_dimension_exploration.sql
    03_date_exploration.sql
    04_measure_exploration.sql
    05_magnitude_analysis.sql
    06_ranking_analysis.sql
    07_change_over_time.sql
    08_cumulative_analysis.sql
    09_performance_analysis.sql
    10_data_segmentation.sql
    11_part_to_whole_analysis.sql
    12_report_customers.sql
    13_report_products.sql
```

## Tech Stack

SQL Server, T-SQL (CTEs, Window Functions, Views)

## Connect

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/muhammad-abdulroqeeb)
