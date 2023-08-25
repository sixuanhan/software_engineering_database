INSERT INTO company_name (c_name)
SELECT DISTINCT name FROM f500_cleaned
UNION
SELECT DISTINCT name FROM top_50_cleaned;

INSERT INTO sector (s_name)
SELECT DISTINCT sector FROM top_50_cleaned;

INSERT INTO state (state_name)
SELECT DISTINCT state FROM city_salary_cleaned;

INSERT INTO city (city_name, state_id)
SELECT city, (SELECT state_id FROM state WHERE state.state_name = city_salary_cleaned.state)
FROM city_salary_cleaned;

INSERT INTO city_econ
SELECT city_id, med_home_p, col_avg, rent_avg, lpp_avg FROM city
NATURAL JOIN city_salary_cleaned;

INSERT INTO city_salary
SELECT city_id, mean_sd_salary_adj, mean_sd_salary_unadj, mean_salary_adj FROM city
NATURAL JOIN city_salary_cleaned;

INSERT INTO city_jobs
SELECT city_id, num_sd_jobs FROM city
NATURAL JOIN city_salary_cleaned;

INSERT INTO company_city
SELECT c_id, city_id FROM company_name
JOIN f500_hq_cleaned ON c_name = name
JOIN city ON f500_hq_cleaned.city = city.city_name;

INSERT INTO company_sector
SELECT c_id, s_id FROM company_name
JOIN top_50_cleaned ON c_name = name
JOIN sector ON sector = s_name;

INSERT INTO company_year
SELECT c_id, year FROM company_name
JOIN top_50_cleaned ON c_name = name;

INSERT INTO company_rank
SELECT c_id, rk FROM company_name
JOIN f500_cleaned ON c_name = name;

INSERT INTO company_employee
SELECT c_id, num_employee_m FROM company_name
JOIN f500_cleaned ON c_name = name;

INSERT INTO company_finance
SELECT c_id, revenues_m, revenue_change_m, profits_m, profit_change_m, assets_m, market_value_m FROM company_name
JOIN f500_cleaned ON c_name = name;
