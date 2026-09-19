# Naming Conventions

This document outlines the naming conventions used across schemas, tables, columns, views, and stored procedures in this data warehouse project.

## General Principles

- Naming style: `snake_case`, with words separated by underscores.
- Language: English.
- Avoid reserved SQL keywords as object names.

---

## Table Naming Conventions

### Bronze Layer
All table names must start with the source system name, and match the original table name from the source system exactly, without renaming.

**Pattern:** `<sourcesystem>_<entity>`
- `<sourcesystem>`: Name of the source system (e.g. `crm`, `erp`)
- `<entity>`: Exact table name from the source system

**Example:** `crm_cust_info` → customer information from the CRM system

### Silver Layer
Same convention as Bronze — table names start with the source system name and preserve the original entity name.

**Pattern:** `<sourcesystem>_<entity>`

**Example:** `crm_cust_info` → cleaned customer information from the CRM system

### Gold Layer
All names must use meaningful, business-aligned names, starting with a category prefix.

**Pattern:** `<category>_<entity>`
- `<category>`: Describes the role of the table — `dim` (dimension) or `fact` (fact table)
- `<entity>`: Descriptive name aligned with the business domain (e.g. `customers`, `products`, `sales`)

**Examples:**
- `dim_customers` — Dimension table for customer data
- `fact_sales` — Fact table containing sales transactions

---

## Column Naming Conventions

### Surrogate Keys
All primary keys in dimension tables must use the suffix `_key`.

**Pattern:** `<table_name>_key`
- `<table_name>`: The entity the key belongs to
- `_key`: Suffix indicating the column is a surrogate key

**Example:** `customer_key` — surrogate key in the `dim_customers` table

### Technical Columns
All system-generated metadata columns must start with the prefix `dwh_`, followed by a descriptive name.

**Pattern:** `dwh_<column_name>`
- `dwh`: Prefix exclusively for system-generated metadata
- `<column_name>`: Descriptive name indicating the column's purpose

**Example:** `dwh_create_date` — system-generated column storing the date a record was loaded

---

## Stored Procedure Naming Conventions

All stored procedures used for loading data must follow the pattern:

**Pattern:** `load_<layer>`
- `<layer>`: The layer being loaded — `bronze`, `silver`, or `gold`

**Examples:**
- `load_bronze` — Stored procedure for loading data into the Bronze layer
- `load_silver` — Stored procedure for loading data into the Silver layer