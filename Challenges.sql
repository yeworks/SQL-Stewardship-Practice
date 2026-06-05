-- =========================================================================
-- [HackerRank] Challenges (Medium)
-- Objective: Output the hacker_id, name, and total challenges created. Exclude hackers with the same challenge count unless their count is the absolute maximum.
-- Technical Focus:
--   - HAVING Clause Subqueries: Filtering grouped data using dynamic aggregated conditions.
--   - SQL Execution Order: Understanding why COUNT() cannot be used inside the GROUP BY clause (ERROR 1056).
--   - Scalar vs. List Comparison: Using '=' for a single maximum value and 'IN' for a dynamically generated list of unique counts.
-- =========================================================================

/*
## Detailed Retrospective & Core Mechanics

### 1. The Execution Order Trap (ERROR 1056)
* The Mistake: I initially tried to group the data by the aggregated count: `GROUP BY count(c.challenge_id)`.
* The Realization: SQL's logical execution order dictates that `GROUP BY` happens *before* aggregation. You cannot group by a metric that hasn't been counted yet. The correct approach is to group by raw columns (`hacker_id`, `name`) and apply aggregate filters later in the 'HAVING' clause.

### 2. Hunting the Dynamic Maximum
* The Challenge: The absolute maximum number of challenges isn't a fixed column in the database; it must be calculated dynamically.
* The Solution: I utilized an inline view (a subquery in the `FROM` clause of another subquery) with a mandatory alias (`sub`) to first count all challenges per hacker, and then extracted the `MAX(cnt)` to use as a scalar benchmark.

### 3. The '=' vs 'IN' Operator Logic
* The Insight: 
  - For the first condition (checking against the absolute max value), the subquery returns a single number (e.g., 50). Thus, a 1:1 match using `=` works perfectly.
  - For the second condition (checking if the count is entirely unique among all hackers), the subquery returns a *list* of valid unique counts (e.g., `[4, 2]`). Therefore, the `IN` operator must be used to check if the current count exists within that bucket.
*/


SELECT h.hacker_id, h.name, count(c.challenge_id) as c_count
from hackers h
join challenges c on h.hacker_id = c.hacker_id
GROUP by h.hacker_id, h.name
-- Condition 1: The count matches the absolute maximum (All top-tier hackers pass)
having c_count = (
    SELECT max(sub.cnt) 
    from (select count(*) as cnt from challenges group by hacker_id) sub
    ) 
OR
-- Condition 2: The count is less than max, but it is unique globally
c_count in (
    SELECT sub2.cnt 
    from (select count(*) as cnt from challenges group by hacker_id) sub2 
    group by sub2.cnt 
    having count(*) = 1
    )
ORDER by c_count DESC , hacker_id ASC;