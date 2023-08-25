# software_engineering_database

This is the submission of the fourth milestone.

## ASCII error in milestone2

I fixed the import error mentioned in the README in milestone2. It was due to the ASCII Code imcompatibility. Here are the steps that I took:

- go to [hexit.it](https://hexed.it/) and open the csv file
- change all occurrences of the curly single quotes and curly double quotes to  straight quotes or double quotes
- save the file

## changes in plan from milestone2

Some changes of data pre-processing from milestone2:

- changed all "-" entries to "null"
- renamed all columns because it's hard to process spaced names (like "company name" instead of "company_name" in MySQL)
- moved the step of parsing composite attributes (namely, the `City` column in `city_salary.csv`) to pre-processing
- dropped the `m_cap` column in `company_finance`
- found and deleted 3 duplicates in `f500_cleaned.csv`

These changes have been updated in [plan.md](/plan.md).


## implementation

To implement the schema of the database from the EER diagram, I used the forward engineering feature in MySQL Workbench. You can find the sql file [here](init.sql).

To import the data from the csv files, I used the Table Data import Wizard.

To Import the data into my database, I followed the Post-import Manipulation process explained in [plan.md](/plan.md).

I wrote [a python script](/brief.py) with the help of ChatGPT to write the DESCRIBE outputs of all the tables to [a txt file](/describes.txt) and write the columns and the first five rows of each table to [another txt file](/first_five_rows.txt). I believe this is more straightforward than uploading a dozen screenshots. Please note that I have omitted my password in the python script for safety reasons.

## query

### question

Show company name, which city its headquarter it is at, and the number of employees of the 15 companies with the most number of employees where the adjusted mean salary for software developers is at least twice the adjusted mean salary for all jobs in the headquarter city.

### query

```sql
SELECT c_name, city_name, num_employees FROM company_name
NATURAL JOIN company_city
NATURAL JOIN company_employee
NATURAL JOIN city
NATURAL JOIN city_salary
WHERE mean_sd_salary_adj > 2 * mean_salary_adj
ORDER BY num_employees DESC
LIMIT 15;
```

### result

```
+-------------------------+------------+---------------+
| c_name                  | city_name  | num_employees |
+-------------------------+------------+---------------+
| kroger                  | cincinnati |        443000 |
| home depot              | atlanta    |        406000 |
| berkshire hathaway      | omaha      |        367700 |
| fedex                   | memphis    |        335767 |
| ups                     | atlanta    |        335520 |
| albertsons cos.         | boise      |        274000 |
| at&t                    | dallas     |        268540 |
| hca holdings            | nashville  |        210500 |
| bank of america corp.   | charlotte  |        208024 |
| darden restaurants      | orlando    |        150942 |
| macy's                  | cincinnati |        148300 |
| american airlines group | fort worth |        122300 |
| tenet healthcare        | dallas     |        116475 |
| procter & gamble        | cincinnati |        105000 |
| coca-cola               | atlanta    |        100300 |
+-------------------------+------------+---------------+
15 rows in set (0.00 sec)
```

### finding

The findings are pretty straightforward. If you're a job seeker looking forward to earning much more than your non-software developer neighbors at a large company, these companies are good choices. The data provides valuable insights into the companies that not only lead in terms of employee strength but also offer higher adjusted mean salaries for software developers compared to the mean salaries across all job roles in their headquarter cities. This combination of employee strength and competitive software developer salaries demonstrates these companies' prominence and commitment to fostering a thriving workforce within their respective urban centers.
