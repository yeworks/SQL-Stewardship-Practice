-- =========================================================================
-- [HackerRank] Weather Observation Station 20 (Medium)
-- Objective: Calculate the Median of a dataset in MySQL (which lacks a built-in MEDIAN function).
-- Technical Focus:
--   - User-Defined Variables (@rowNumer): Manually indexed rows to track the exact position of each data point.
--   - Subqueries (Inline Views): Staged the sorted and indexed data into a temporary table ('m') for further calculation.
--   - Algorithmic Index Targeting: Applied FLOOR() and CEIL() to dynamically extract the exact median index, handling both odd and even index.
-- =========================================================================

SET @rowNumer := -1;
 
SELECT
   round(avg(m.lat_n),4)
from
   (SELECT @rowNumer:=@rowNumer + 1 as rowNumer,
           station.lat_n
    from station
    order by station.lat_n) as m
where
m.rowNumer in (FLOOR(@rowNumer / 2), CEIL(@rowNumer / 2));
