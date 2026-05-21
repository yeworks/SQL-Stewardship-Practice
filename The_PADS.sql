-- =========================================================================
-- [HackerRank] The PADS (Medium)
-- Objective: Generate formatted text reports using string manipulation and aggregation.
-- Technical Focus:
--   - Used CONCAT(), SUBSTR(), and LOWER() for data formatting and cleaning.
--   - Prevented unintended whitespace issues by replacing comma-separation with explicit CONCAT().
--   - Handled proper data aggregation with GROUP BY and structured multi-column ORDER BY logic.
-- =========================================================================

-- Query 1: Format names with their occupation initials
SELECT concat(name, "(",substr(occupation,1,1),")" )
FROM occupations 
order by name ASC;

-- Query 2: Aggregate count of each occupation and format as a lowercase summary
SELECT concat("There are a total of",' ',count(occupation),' ',lower(occupation),"s.")
FROM occupations 
group by occupation order by count(occupation) ASC, occupation ASC;
