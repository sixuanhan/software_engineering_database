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

These changes have been updated in [plan.md](/plan.md).
