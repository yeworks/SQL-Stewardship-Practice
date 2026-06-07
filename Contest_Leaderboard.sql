-- =========================================================================
-- [HackerRank] Contest Leaderboard (Medium)
-- Objective: Calculate the total score for each hacker by summing their maximum scores for each challenge, excluding hackers with a total score of 0.
-- Technical Focus:
--   - Inline View (FROM Subquery): Overcoming the 'Invalid use of group function' error by pre-aggregating data into a virtual table.
--   - Two-Tier Aggregation: Executing MAX() at the challenge level first, and then SUM() at the hacker level.
--   - HAVING Clause: Filtering aggregated results (total_score > 0) after the GROUP BY phase.
-- =========================================================================

/*
## Detailed Retrospective & Core Mechanics

### 1. The Double Aggregation Trap (ERROR 1111)
* The Mistake: I initially attempted to calculate the total of maximum scores using nested aggregate functions: `SUM(MAX(score))`.
* The Realization: SQL strictly prohibits nesting aggregate functions (ERROR 1111: Invalid use of group function). Once a dataset is aggregated (e.g., collapsed into MAX), it cannot be re-aggregated in the same SELECT statement. The operation must be split into two distinct phases.

### 2. Utilizing an Inline View (Virtual Table)
* The Concept: Since I couldn't do `SUM(MAX())` at once, I needed to create a temporary table that already contains the `MAX(score)` for each challenge per hacker.
* The Implementation: I placed a subquery in the `FROM` clause. Because this subquery returns multiple columns (`hacker_id`, `challenge_id`, `max(score)`), it acts as a fully-fledged 2D table known as an "Inline View".
* The "Aha!" Moment on JOINs: Unlike Scalar Subqueries (which return a single value and act like a variable), an Inline View creates a virtual table. To combine this virtual table (`sub`) with the physical `hackers` table, an explicit `JOIN` and `ON` condition is absolutely mandatory to map the rows correctly.

### 3. Proper Placement of Filtering Conditions
* Filtering total scores greater than 0 (`> 0`) cannot be done in the `WHERE` clause because the total score is an aggregated metric (`SUM()`). This condition must be applied in the `HAVING` clause, which evaluates data *after* the `GROUP BY` execution phase.
*/

SELECT h.hacker_id, h.name, sum(sub.maximum)
from hackers h
join (
    SELECT hacker_id, challenge_id, max(score) as maximum  from submissions
    GROUP by hacker_id, challenge_id
)sub
on h.hacker_id = sub.hacker_id
GROUP by h.hacker_id, h.name
having sum(sub.maximum) > 0
ORDER by sum(sub.maximum) DESC, h.hacker_id ASC;