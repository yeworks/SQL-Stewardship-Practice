-- =========================================================================
-- [HackerRank] Print Prime Numbers (Medium)
-- Objective: Write a query to print all prime numbers less than or equal to 1000. 
--            Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
-- Technical Focus:
--   - Recursive CTE (WITH RECURSIVE): Generating a sequence of numbers virtually without using physical system tables.
--   - Mathematical Logic to SQL: Translating the definition of a prime number into a 'NOT EXISTS' subquery.
--   - String Aggregation: Using GROUP_CONCAT to flatten multiple rows into a single string.
-- =========================================================================

/*
## Detailed Retrospective & Core Mechanics

### 1. Generating the Number Sequence (The "Virtual Board")
* SQL is designed to query existing data, not to run loops. To check for primes, I first needed a list of numbers from 2 to 1000.
* Instead of relying on `INFORMATION_SCHEMA`, I used `WITH RECURSIVE numbers AS (...)` to define a virtual table. 
* It acts like a `while` loop: starts with 2, and continuously adds 1 to the previous number until it hits 1000.

### 2. The Prime Number Logic (`NOT EXISTS`)
* A prime number has no divisors other than 1 and itself. In SQL terms: "There should NOT EXIST any smaller number that divides my number with a remainder of 0."
* **The Filter:** `n1.num % n2.num = 0`.
* **The Crucial Condition:** `n2.num < n1.num`. This prevents the number from dividing by itself (e.g., 7 % 7 = 0), which would incorrectly disqualify every single number from being a prime.

### 3. Formatting the Output
* The problem requires a single string like `2&3&5&7...`
* Using `GROUP_CONCAT(num SEPARATOR '&')` merges all the rows that survived the `NOT EXISTS` filter into one horizontal line. 
* Dropping the `GROUP BY` clause is essential here, otherwise the output would remain separated vertically.
*/


-- Create a virtual table of numbers from 2 to 1000
with RECURSIVE numbers as (
    select 2 as num
    union all
    select num + 1 from numbers where num < 1000
)

-- Filter primes and concatenate them into a single string
select GROUP_CONCAT(num SEPARATOR '&')
from numbers n1
where not EXISTS (
    select 1
    from numbers n2
    where n2.num < n1.num and n1.num % n2.num = 0
); 