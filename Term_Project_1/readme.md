# Data Engineering Term Project 1

**Author: Marcell Magda**

**Year Created: 2023**

**Project Files:**
- Operational Layer [Operational_Layer_1](https://github.com/MarcellM01/Data_Engineering_1/blob/main/Term_Project_1/Operational_Layer_1.sql)
- Analytical Layer and ETL Pipeline [Analytical_Layer_2](https://github.com/MarcellM01/Data_Engineering_1/blob/main/Term_Project_1/Analytical_layer_2.sql)
- Data Marts [Data_Marts_3](https://github.com/MarcellM01/Data_Engineering_1/blob/main/Term_Project_1/Data_Marts_3.sql)

## Dataset Related Information:
The dataset being used was imported from [kaggle.com](https://www.kaggle.com/datasets/algorismus/adventure-works-in-excel-tables) and is based on Microsoft's Adventure Works SQL database, a sample database created by the software
company to help those learning SQL. The contents of this database are entirely fictitious and are supposed to emulate a bike-selling firm's internal 
records as they record transactions, reseller-related information, geographical info, and many others (to be detailed in the operational layer below). 
Although the dataset was originally published in 2008, the version being used for the purposes of this Term Project is dated 2022.



## Operational Layer [Operational_Layer_1](https://github.com/MarcellM01/Data_Engineering_1/blob/main/Term_Project_1/Operational_Layer_1.sql):

My operational layer consists of 6 tables. The structure for these tables is created, and their contents are loaded within the operational layer file itself,
for the ease of reproducibility. The original dataset covers sales data for over 52 thousand transactions, this was trimmed down to a more manageable 800 
by using a method of random sampling.

**Important:** The original dataset downloaded contained 7 tables, one of which, namely the "Targets" table was dropped as it was not relevant
for my analysis.

**Data Tables:**

1. **sales_shortened:** This table represents the trimmed-down sales data containing information such as
   SalesOrderNumber, OrderDate, ProductKey, ResellerKey, EmployeeKey, SalesTerritoryKey, Quantity, UnitPrice, Sales, and Cost.
   It is the core table in this operational layer.

2. **product:** This table stores information about products, including ProductKey, Product name, StandardCost, Color,
   Subcategory, Category, BackgroundColorFormat, and FontColorFormat.

3. **reseller:** The reseller table holds data related to resellers, with fields like ResellerKey, BusinessType,
   Reseller name, City, StateProvince, and CountryRegion.

4. **salesperson:** It stores information about salespersons, including EmployeeKey, EmployeeID, Salesperson name,
   Title, and UPN.

5. **salespersonregion:** This table defines the relationship between salespersons and sales territories using EmployeeKey
    and SalesTerritoryKey.

6. **region:** The region table holds information about sales territories, including SalesTerritoryKey, Region name,
    Country, and Group.

These tables collectively form the operational layer of the database and serve as the foundation for data analysis and reporting.

**EER Diagram:**

The EER diagram depicted here is a representation of the star schema created by utilizing the "sales_shortened" table as the main table
![A_W_EER_Diagram](https://github.com/MarcellM01/Data_Engineering_1/assets/9119122/44d5bf0a-701f-42e6-8277-1eac79ea47e7)

## Analytics Plan and Analytical Layer [Analytical_Layer_2](https://github.com/MarcellM01/Data_Engineering_1/blob/main/Term_Project_1/Analytical_layer_2.sql):

Before the analytical plan was formulated, the datasets were thoroughly analyzed in mySQL where familiarity with the data columns,
rows, and primary keys was gained. It involved creating one huge table through a series of inner joins that contained
all of the columns of all 6 tables in one common table, which would later see the irrelevant columns excluded as part of the 
analytical layer creation process.

**From this process, the following series of questions emerged:**
- Out of all of the products sold by this firm, which are ranked the highest by their Profit/Profit Margin?
- Which Product categories are the ones that see the most volume of sales?
- Which regions see the most sales by volume, are there within the US, or many abroad?
- Which resellers have the highest revenue numbers, who is performing the best?
- Which salespeople are the most productive and what region do they belong to?

**Building of the Analaytical_Store and the ETL Pipeline:**
- Firstly, the analytical layer was created under the name "analytical_store". This contained all of the relevant columns
  for the analysis (a bit more even however, some columns ended up not being used).
- Secondly, the "analytics_store" was reformatted as a procedure, namely the "CreateAnalyticalStore" procedure to be used later in the pipeline as
  the addition of new columns would necessitate the refreshing of the "analytical_store table".
- Thirdly, and lastly, the procedure responsible for adding new data was created under the name "InsertNewSaleProc". This procedure allows the user
  to add new rows of data to the main "sales_shortened" table whenever there is a new transaction.
- This whole process in the end gave us two procedures, one which gives the ability to create new rows in the main table, and the
  other which allows for the creation/refreshing of the "analytics_store".

**Important:** An additional table, namely the "messages" table is created when calling the "InsertNewSaleProc procedure", this stores the transaction numbers. 

## Data Marts [Data_Marts_3](https://github.com/MarcellM01/Data_Engineering_1/blob/main/Term_Project_1/Data_Marts_3.sql):

**Data Mart 1: Product Performance**

This data mart provides a comprehensive overview of product performance within the business. It includes aggregated measures of quantity sold, total revenue, total profit, and profit margin for each product. Key attributes include ProductKey, Product, Subcategory, and Category. With this information, businesses can identify their most profitable products and make informed decisions about inventory management, marketing strategies, and product development.

**Data Mart 2: Sales By Region**

The Sales By Region data mart is designed to uncover sales patterns across different geographic regions. It summarizes data to include the number of distinct resellers, total revenue, and quantity sold, with regional segmentation provided by attributes such as SalesTerritoryKey, Region, Country, and TerritoryGroup. This view is crucial for regional sales analysis and for formulating targeted sales strategies.

**Data Mart 3: Reseller Performance**

This data mart evaluates the performance of resellers by providing metrics like total revenue and quantity sold, alongside demographic information such as state and country of origin. The view encapsulates details on the ResellerKey, ResellerName, ResellerBusinessType, ResellerCity, ResellerState, and ResellerCountry. It serves as a tool for assessing the reseller channel's contribution to the business and optimizing channel strategies.

**Data Mart 4: SalesPerson Performance**
Focusing on individual performance metrics, the SalesPerson Performance data mart ranks salespersons based on the sum of sales (denoted as 'Performance'), further segmented by region and country. It includes details like the Salesperson name alongside their respective Region and Country. This information is vital for sales management, allowing for performance tracking, incentivization, and identifying areas needing sales support or additional training.

