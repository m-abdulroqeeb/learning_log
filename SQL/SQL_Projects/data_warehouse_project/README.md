# Data Warehouse Project

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/muhammad-abdulroqeeb)

A SQL Server data warehouse built using the Medallion Architecture (Bronze, Silver, Gold), following @datawithbaraa's Data Warehouse course, as part of my data engineering learning journey.

## About

This project demonstrates a full ETL pipeline, from raw source data (CRM and ERP CSV files) through cleaning and standardization, to business-ready star schema views for reporting and analysis.

This is a guided, tutorial-based project. I wrote and debugged every script myself, and documented my own understanding throughout, but the architecture and approach follow the course structure rather than an original design. My own independently-designed project, built on a different dataset, is a separate piece of work planned for later in my learning journey.

## Architecture

Three layers, following the Medallion Architecture pattern:

- **Bronze** — Raw, unprocessed data loaded as-is from source CSV files.
- **Silver** — Cleaned, standardized, and validated data.
- **Gold** — Business-ready data, modeled as a Star Schema (dimension and fact views) for consumption.

See `docs/data_architecture.png` and `docs/data_flow.png` for visual diagrams.

## Structure

```
data_warehouse_project/
  README.md
  init_database.sql
  docs/
    naming_conventions.md
    data_catalog.md
    data_architecture.png
    data_flow.png
    data_integration.png
    data_model.png
  scripts/
    bronze/
      ddl_bronze.sql
      proc_load_bronze.sql
    silver/
      ddl_silver.sql
      proc_load_silver.sql
    gold/
      ddl_gold.sql
  tests/
    quality_checks_silver.sql
    quality_checks_gold.sql
```

## Tech Stack

SQL Server, T-SQL (DDL, DML, Stored Procedures, Views, BULK INSERT)

## Data Source

Sample CRM and ERP CSV data, provided as part of the course material by @datawithbaraa. Used unmodified, for learning purposes only.

## Credits

Course structure and dataset: [@datawithbaraa](https://youtu.be/SSKVgrwhzus?si=g0BrrJKg7YaLAsvL)

## Connect

Following along or have feedback? Reach out on LinkedIn above.
