-- question: show company name, which city its headquarter it is at, and the number of employees of the 15 companies with the most number of employees
-- where the adjusted mean salary for software developers is at least twice the adjusted mean salary for all jobs in the headquarter city

SELECT c_name, city_name, num_employees FROM company_name
NATURAL JOIN company_city
NATURAL JOIN company_employee
NATURAL JOIN city
NATURAL JOIN city_salary
WHERE mean_sd_salary_adj > 2 * mean_salary_adj
ORDER BY num_employees DESC
LIMIT 15;