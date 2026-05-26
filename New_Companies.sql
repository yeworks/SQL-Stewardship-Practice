-- =========================================================================
-- [HackerRank] New Companies (Medium)
-- Objective: Output company details along with the distinct counts of various management roles.
-- Technical Focus:
--   - Optimized query performance by using a single master table ('employee') that contains all necessary foreign keys, eliminating the need for an inefficient 5-table join.
--   - Applied RIGHT JOIN to ensure company records are fully preserved even if no employee data is present (ensuring data completeness).
--   - Standardized GROUP BY alignment with non-aggregated SELECT columns.
-- =========================================================================

SELECT company.company_code, company.founder,count(distinct employee.lead_manager_code), count(distinct employee.senior_manager_code),
count(distinct employee.manager_code), count(distinct employee.employee_code) 
from employee 
right join company on employee.company_code = company.company_code
GROUP by company.company_code, company.founder
order by company.company_code ASC;
