# CareerCode

This is the project site for my final project for COSC 61: Database System that I took during summer 2023 with Professor Adam Goldstein. My goal is to find interesting datasets from the internet, design and build a database out of the datasets, explore findings using SQL queries, and add interesting features to the database.

Please checkout the branches for milestone submissions and the wiki for detailed documentation. Specifically for Milestone 4, the README.md file contains more detailed information on how I arrived at the final product.

## folders

- `data_demo`: this folder contains a python script that produces the other two txt files, which shows the schema and contents of the database.
- `img`: contains relevant media.
- `queries`: this folder contains example questions that the database can answer, some example queries and results that give insights on software development job search, and [queries](queries/queries.sql) that I used in the Retool app.
- `source_data`: this folder contains raw data from Kaggle and cleaned data. Refer to [the Database Design, Cleaning and Import Plan](plan.md) to see how I cleaned the data.
- sql_files: contains sql files that initialize the database, import data from the csv's to the database, and export/dump the data to AWS RDS.
