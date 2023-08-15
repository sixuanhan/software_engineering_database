SELECT c_name, city_name, num_employees FROM company_name
NATURAL JOIN company_city
NATURAL JOIN company_employee
NATURAL JOIN city
NATURAL JOIN city_salary
WHERE mean_sd_salary_adj > 2 * mean_salary_adj
ORDER BY num_employees DESC
LIMIT 15;