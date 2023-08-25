-- The following queries are the ones I used in Retool

-- show_from_table
USE swe;
SELECT * FROM {{select1.value}};

-- conditional_search
USE swe;
SELECT c_name, num_employees, c_rank, city_name, mean_sd_salary_adj, mean_sd_salary_adj/mean_salary_adj AS ratio, revenues, profits, m_value, f_yr
FROM company_name
LEFT JOIN company_city ON company_name.c_id = company_city.c_id
LEFT JOIN company_employee ON company_name.c_id = company_employee.c_id
LEFT JOIN company_rank ON company_name.c_id = company_rank.c_id
LEFT JOIN city ON company_city.city_id = city.city_id
LEFT JOIN city_salary ON company_city.city_id = city_salary.city_id
LEFT JOIN f500_hq_cleaned ON c_name = f500_hq_cleaned.name
LEFT JOIN company_finance ON company_name.c_id = company_finance.c_id
LEFT JOIN company_year ON company_name.c_id = company_year.c_id
WHERE (
-- check for city
({{!textInput2.value}} OR LOWER(city_name) = LOWER('{{textInput2.value}}'))
-- AND check for state
AND ({{!textInput3.value}} OR LOWER(f500_hq_cleaned.state) = LOWER('{{textInput3.value}}'))
-- AND check for size
AND (
    ('{{select3.value}}' = 'small' AND num_employees < 10000) OR
    ('{{select3.value}}' = 'medium' AND num_employees < 100000) OR
    ('{{select3.value}}' = 'big' AND num_employees >= 100000) OR
  {{!select3.value}} OR '{{select3.value}}' = 'all'
)
);

-- search_by_company_name
USE swe;
SELECT c_name, num_employees, c_rank, city_name, mean_sd_salary_adj, mean_sd_salary_adj/mean_salary_adj AS ratio, state, revenues, profits, m_value, f_yr
FROM company_name
LEFT JOIN company_city ON company_name.c_id = company_city.c_id
LEFT JOIN company_employee ON company_name.c_id = company_employee.c_id
LEFT JOIN company_rank ON company_name.c_id = company_rank.c_id
LEFT JOIN city ON company_city.city_id = city.city_id
LEFT JOIN city_salary ON company_city.city_id = city_salary.city_id
LEFT JOIN f500_hq_cleaned ON c_name = f500_hq_cleaned.name
LEFT JOIN company_finance ON company_name.c_id = company_finance.c_id
LEFT JOIN company_year ON company_name.c_id = company_year.c_id
WHERE {{!textInput1.value}} OR c_name like '%{{textInput1.value}}%'
;

-- city_recommendation
USE swe;
SELECT city_name, med_home_p, col_avg, rent_avg, lpp_avg, num_sd_jobs,mean_sd_salary_adj, mean_sd_salary_adj/mean_salary_adj AS ratio, mean_sd_salary_adj/(col_avg+rent_avg) AS survivability
FROM city
NATURAL JOIN city_econ
NATURAL JOIN city_jobs
NATURAL JOIN city_salary
;