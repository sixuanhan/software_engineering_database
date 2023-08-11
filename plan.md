# Pseudocode

## Pre-import Manipulation

main tasks

- normalize company names
  - normalize to all lower case
  - standardize names according to `Fortune 500 Companies US.csv`: eg. 'Apple' might appear as 'Apple' or 'Apple Inc.' We would change all instances of 'Apple' to 'Apple Inc.' if the company is referred to 'Apple Inc.' in `Fortune 500 Companies US.csv`.

- delete unecessary columns

- data transformation
  - convert data format as required by the database schema
  

### Fortune 500 Companies US.csv

- fix ASCII error
- rename file name and column names
- change all `Company Name` to lowercase
- change `Number of Employees` data type to `INT`
- delete the dollar sign and commas from `Revenue`, `Profits`, `Assets`, and `Market Value` columns
- change the percentages to floats from `Revenue Change` and `Profit Change` column

### Fortune_500_Corporate_Headquarters.csv

- fix ASCII error
- rename file name and column names
- change all `NAME` to lowercase
- only keep `NAME`, `CITY`, and `STATE` columns

### Top 50 US Tech Companies 2022 - 2023.csv

- rename file name and column names
- standardize `Company name`
- remove the `Industry` column
- remove all columns after `Founding Year`

### city_salary.csv

- rename file name and column names
- name the first column `city_id`
- replace the second column with the `City` column and delete the `Metro` column
- parse `City` column in `city_salary` into two columns: `City` and `State`

## Import processes

### import csv's as individual tables
I will use the Table Data Import Wizard provided in MySQL Workbench to import the csv's.

### forward engineer the EER diagram to create tables

Need to delete the foreign key constraint name in every occurrence in the automatically produced code to create the schemas.

## Post-import Manipulation

main tasks

- data validation
  - make sure that all the company names match and there is only one unique company name referring to a company. Eg. There should be no 'Apple' and 'Apple Inc' or 'Walmart' and 'walmart'.
  - make sure that all the values are right and not missing
  - make sure that data types align
  - no redundancy

- organize information from the csv-produced tables into the EER-produced tables
  - company_name
    - put all `company name` from `Fortune_500_Companies_US` into the `company_name` table
    - put all `Company Name` from `Top_50_US_Tech_Companies` that's not already in the `company_name` table into the `company_name` table
  - sector
    - put all distinct `Sector` from `Top_50_US_Tech_Companies` into the `sector` table
  - state
    - put all distinct `state` from `city_salary` into the `state` table
  - city
    - put all `city` from `city_salary` into the `city` table and match with `state_id`
  - city_econ, city_jobs, city_salary
    - update from `city_salary`
  - company_city
    - update from `Fortune_500_Corporate_Headquarters`
  - company_sector
    - update from `Top_50_US_Tech_Companies`
  - company_year
    - update from `Top_50_US_Tech_Companies`
  - company_rank, company_employee, company_finance
    - update from `Fortune_500_Companies_US`
