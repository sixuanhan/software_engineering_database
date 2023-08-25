# CareerCode

This is the project site for my final project for COSC 61: Database System that I took during summer 2023 with Professor Adam Goldstein. My goal is to find interesting datasets from the internet, design and build a database out of the datasets, explore findings using SQL queries, and add interesting features to the database.

Please checkout the branches for milestone submissions. Specifically for Milestone 4, the README.md file contains more detailed information on how I arrived at the final product.

## final product

I present **CareerCode**: start your career as a software developer in the easiest way possible.

![screenshot](img/careercode.png)

Find a video demonstration of the app [here](img/demo.mp4).

## folders

- data_demo: this folder contains a python script that produces the other two txt files, which shows the schema and contents of the database.
- img: contains relevant media.
- queries: this folder contains example questions that the database can answer, some example queries and results that give insights on software development job search, and [queries](queries/queries.sql) that I used in the Retool app.
- source_data: this folder contains raw data from Kaggle and cleaned data. Refer to [the Database Design, Cleaning and Import Plan](plan.md) to see how I cleaned the data.
- sql_files: contains sql files that initialize the database, import data from the csv's to the database, and export/dump the data to AWS RDS.

## Next steps

- The current UI does not look pretty. Can integrate CSS (I could not figure out how to do that in the low-code platform. I had already spent 10 hours on this task in total by then) to make the front-end look more pretty. Here is a [UI low-fidelity design](img/UI_demo.mp4) that I made with Figma, indicating how it could look like.
- The current website only supports searching by a few attributes. Ideally, the website would enable searching with any of the existing attributes.
- Update: the users could contribute to the database by updating it with the latest information on the companies, city data, etc. Of course, with the permission of the admin.
- Automation: keeps track of relevant datasets and update data automatically when new data is updated (eg. a new release of the fortune 500 rank).
