-- =========================================================================
-- [HackerRank] Symmetric Pairs (Medium)
-- Objective: Output the symmetric pairs of (X, Y) ordered by the value of X in ascending order.
-- Technical Focus:
--   - Mathematical Logic to SQL: Translating the concept of "Symmetry" into a Self Join condition (f1.X = f2.Y AND f1.Y = f2.X).
--   - Edge Case Handling: Separating the logic for distinct pairs (X != Y) and identical pairs (X = Y).
--   - UNION Operator: Vertically stacking results from two distinct queries that share the same column count and data types.
-- =========================================================================

/*
## Detailed Retrospective & Core Mechanics

### 1. The Trap of a Single Query
* Initial thought: Tried to solve everything in one go using nested subqueries in the `WHERE` clause or mixing `GROUP BY` logic.
* The Realization: The problem fundamentally consists of two mutually exclusive cases. Mixing them destroys the logic (e.g., `GROUP BY` kills valid asymmetric pairs). The most elegant solution is to solve them independently and stack them using `UNION`.

### 2. Case A: The Asymmetric Pairs ($X < Y$)
* To find a mirror pair like (13, 15) and (15, 13), I utilized a **Self Join**.
* The "Mirror" Condition: `f1.x = f2.y AND f1.y = f2.x`. This perfectly cross-matches the values to guarantee symmetry.
* The Filter: `WHERE f1.x < f1.y` ensures we only print the pair once and inherently removes the cases where $X = Y$.

### 3. Case B: The Identical Pairs ($X = Y$)
* For cases like (20, 20), symmetry only exists if the exact same row was inserted **more than once** into the table.
* Therefore, instead of joining, I used `GROUP BY x, y` and applied `HAVING COUNT(*) > 1` to filter out the lonely, single occurrences.

### 4. Vertical Stacking with `UNION`
* Unlike `JOIN` (which merges horizontally and requires an `ON` condition), `UNION` simply pours the results of the second query directly under the first. 
* The absolute rule: Both queries must output the exact same number of columns with matching data types (in this case, two integer columns for X and Y). No `ON` clause needed.
*/

-- Case A: Asymmetric Pairs
SELECT f1.x,f1.y 
from functions f1 
join functions f2 on f1.x = f2.y and f1.y = f2.x
where f1.x < f1.y

union 

-- Case B: Identical Pairs (Duplicates)
SELECT x, y
from functions
where x = y
group by x, y
having COUNT(*) > 1

order by x ASC;