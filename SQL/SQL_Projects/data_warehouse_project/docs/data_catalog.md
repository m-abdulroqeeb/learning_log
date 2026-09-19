# Data Catalog — Gold Layer

## Overview
The Gold layer represents business-ready data, structured as a Star Schema, consisting of dimension and fact views for reporting and analytics.

---

## 1. gold.dim_customers
**Purpose:** Stores customer details enriched with demographic and geographic data.

| Column Name      | Data Type     | Description                                                                 |
|-------------------|--------------|-------------------------------------------------------------------------------|
| customer_key      | INT           | Surrogate key uniquely identifying each customer record in the dimension.   |
| customer_id       | INT           | Unique numerical identifier assigned to each customer (source system ID).   |
| customer_number   | NVARCHAR(50)  | Alphanumeric identifier used to track the customer (source system key).     |
| first_name        | NVARCHAR(50)  | Customer's first name, as recorded in the CRM source.                       |
| last_name         | NVARCHAR(50)  | Customer's last name, as recorded in the CRM source.                        |
| country           | NVARCHAR(50)  | Country of residence for the customer (e.g. 'Germany', 'United States').    |
| marital_status    | NVARCHAR(50)  | Marital status of the customer (e.g. 'Married', 'Single').                  |
| gender            | NVARCHAR(50)  | Gender of the customer. CRM is the primary source; ERP fills in gaps.       |
| birthdate         | DATE          | Date of birth. NULL if the source value was invalid (future date).          |
| create_date       | DATE          | Date the customer record was first created in the CRM source system.       |

---

## 2. gold.dim_products
**Purpose:** Stores current product details, categorization, and pricing. Historical product versions are excluded.

| Column Name      | Data Type     | Description                                                                 |
|-------------------|--------------|-------------------------------------------------------------------------------|
| product_key       | INT           | Surrogate key uniquely identifying each product record in the dimension.    |
| product_id        | INT           | Unique numerical identifier assigned to the product (source system ID).     |
| product_number    | NVARCHAR(50)  | Structured alphanumeric code identifying the product (extracted key).       |
| product_name      | NVARCHAR(50)  | Descriptive name of the product.                                            |
| category_id       | NVARCHAR(50)  | Identifier linking the product to its category (extracted from prd_key).    |
| category          | NVARCHAR(50)  | High-level classification of the product (e.g. 'Bikes', 'Components').      |
| subcategory       | NVARCHAR(50)  | More specific classification within the category.                           |
| maintenance       | NVARCHAR(50)  | Indicates whether the product requires maintenance (e.g. 'Yes', 'No').      |
| cost              | INT           | Cost of the product, in whole currency units.                               |
| product_line      | NVARCHAR(50)  | Product line the item belongs to (e.g. 'Mountain', 'Road', 'Touring').      |
| start_date        | DATE          | Date the product became available/active.                                   |

---

## 3. gold.fact_sales
**Purpose:** Stores transactional sales data, linking to customer and product dimensions, for analytical and reporting use.

| Column Name    | Data Type     | Description                                                                 |
|------------------|--------------|-------------------------------------------------------------------------------|
| order_number     | NVARCHAR(50)  | Unique identifier for each sales order (e.g. 'SO54496').                    |
| product_key      | INT           | Foreign key linking to gold.dim_products.product_key.                       |
| customer_key     | INT           | Foreign key linking to gold.dim_customers.customer_key.                     |
| order_date       | DATE          | Date the order was placed.                                                  |
| shipping_date    | DATE          | Date the order was shipped.                                                 |
| due_date         | DATE          | Date the order payment was due.                                             |
| sales_amount     | INT           | Total monetary value of the sale, in whole currency units.                  |
| quantity         | INT           | Number of units ordered.                                                    |
| price            | INT           | Price per unit for the ordered item, in whole currency units.               |