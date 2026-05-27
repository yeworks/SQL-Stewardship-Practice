-- =========================================================================
-- [HackerRank] Weather Observation Station 18 (Medium)
-- Objective: Calculate the Manhattan Distance between two points (P1, P2) on a 2D plane.
-- Technical Focus:
--   - Applied mathematical functions: ROUND(), ABS(), MIN(), MAX().
--   - Correctly matched coordinate components (Latitude with Latitude, Longitude with Longitude) to calculate distance.
--   - Overcame misleading problem descriptions by focusing on the core mathematical logic (Manhattan Distance formula).
-- =========================================================================

SELECT round(abs(min(lat_n) - max(lat_n)) + abs(min(long_w) - max(long_w)),4) 
from station;
