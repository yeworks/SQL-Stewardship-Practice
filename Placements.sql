-- =========================================================================
-- [HackerRank] Placements (Medium)
-- Objective: Output the names of students whose best friends got offered a higher salary than them.
-- Technical Focus:
--   - Continuous JOINs: Chaining multiple tables to aggregate related data into a single row.
--   - Self Join Pattern (Table Aliasing): Joining the same 'packages' table twice using different aliases (p1, p2) to compare two separate entities (My Salary vs. Friend's Salary) within the same query.
-- =========================================================================

/*
## Detailed Retrospective & Core Mechanics

### 1. Breaking the "One Table, One Purpose" Illusion
* The Confusion: Initially, joining the exact same table (`packages`) twice in a single query felt abstract. I assumed the `id` column in `packages` was strictly hardcoded to my own student ID.
* The Realization: Through hands-on execution, I realized a table is just a lookup tool. By assigning different aliases, I can create multiple independent instances (virtual copies) of the same table.

### 2. The "Two Kiosks" Concept (Mastering Multiple Aliases)
* To get both salaries on a single horizontal row, I treated the `packages` table like a barcode scanner (kiosk):
  - **Kiosk 1 (`p1`)**: I plugged in my own ID (`s.id = p1.id`) to fetch my salary.
  - **Kiosk 2 (`p2`)**: I plugged in my friend's ID (`f.friend_id = p2.id`), which I got from the `friends` table, to fetch their salary.
* This explicitly tells the SQL engine to fetch two different salaries based on two different lookup keys, combining them side-by-side.

### 3. Final Execution
* With my salary (`p1.salary`) and my friend's salary (`p2.salary`) perfectly aligned in the same row, filtering became as simple as writing `WHERE p2.salary > p1.salary`.
* Bypassed the need for complex subqueries or aggregations like `GROUP BY` by utilizing clean, direct JOINs.
*/

SELECT s.name from students s
join packages p1 on s.id = p1.id
join friends f on s.id = f.id
join packages p2 on f.friend_id = p2.id
where p2.salary > p1.salary
ORDER by p2.salary ASC;