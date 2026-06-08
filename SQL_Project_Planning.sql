- =========================================================================
-- [HackerRank] SQL Project Planning (Medium)
-- Objective: Find the start and end dates of projects completed on consecutive days, sorted by project duration and start date.
-- Technical Focus:
--   - Gaps and Islands Problem: Identifying the absolute boundaries of continuous data sequences.
--   - Boundary Detection via Subqueries: Using `NOT IN` to isolate 'True Start Dates' and 'True End Dates'.
--   - Non-Equi Join & MIN() Pairing: Matching each start date with its closest valid future end date without a direct ID match.
-- =========================================================================

/*
## Detailed Retrospective & Core Mechanics

### 1. Breaking Away from Row-by-Row Logic (The `DISTINCT` & `CASE` Trap)
* Initial Approach: I tried using `DISTINCT` or logical flow like `CASE` / `IF` / `THEN` to check if `start_date = end_date + 1`. 
* The Realization: SQL isn't designed to iterate row-by-row like Python. To find consecutive blocks (Islands), I had to stop looking at the connections and start looking at the **Boundaries**.

### 2. Identifying True Boundaries (Inline Views & `NOT IN`)
* **True Start Dates:** A project's absolute start date has no preceding task. Therefore, it is a `start_date` that strictly does NOT exist in the `end_date` column.
* **True End Dates:** Conversely, an absolute end date has no following task. It is an `end_date` that strictly does NOT exist in the `start_date` column.
* *Note:* You cannot just write `NOT IN end_date`. You must use a subquery `(SELECT end_date FROM projects)` to pass a valid list of values to the IN operator. I created two separate Inline Views for these boundaries.

### 3. The Non-Equi Join (The "Aha!" Moment)
* Now I had two virtual tables: one for Starts (`s`) and one for Ends (`e`).
* Unlike previous joins using `=` (Equi-Join), I joined these tables on a chronological condition: `s.start_date < e.end_date`.
* For any single start date, there are multiple future end dates. To find the *exact* end date for that specific project, I grouped by `start_date` and selected the nearest future date using `MIN(e.end_date)`. 

### 4. DATEDIFF Sensitivity
* `DATEDIFF(A, B)` literally calculates `A - B`. To get a positive duration for ordering, it must be `DATEDIFF(MIN(e.end_date), s.start_date)`.
*/

SELECT s.start_date, min(e.end_date)
FROM
    (
    SELECT start_date from projects where start_date not in (SELECT end_date FROM projects)
    )s
join (  
    SELECT end_date from projects where end_date not in (SELECT start_date FROM projects)
    )e
on s.start_date < e.end_date 
GROUP by s.start_date 
order by datediff(min(e.end_date),s.start_date) ASC, start_date ASC;