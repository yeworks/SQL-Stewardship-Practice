-- =========================================================================
-- [HackerRank] Weather Observation Station 19 (Medium)
-- Objective: Calculate the Euclidean Distance between two points (P1, P2) on a 2D plane.
-- Technical Focus:
--   - Applied mathematical functions: SQRT(), POW(), ROUND(), MIN(), MAX().
--   - Correctly structured nested mathematical operations to translate the Euclidean distance formula into SQL.
--   - Leveraged logical spatial data grouping (Lat with Lat, Long with Long) based on prior coordinate problem-solving experience.
-- =========================================================================

SELECT round(sqrt(pow(max(lat_n) - min(lat_n),2) + pow(max(long_w) - min(long_w),2)),4)
from station;
