-- =========================================================================
-- [HackerRank] Top Competitors (Medium)
-- Objective: Find hackers who achieved full scores in more than one challenge.
-- Technical Focus:
--   - Multi-Table JOINs: Sequentially joined 4 tables (hackers, submissions, challenges, difficulty) to establish the relationships.
--   - Filtering: Compared submissions.score directly with difficulty.score to find "full score" without hardcoding values.
--   - Aggregation & HAVING: Grouped by hacker and used HAVING COUNT() > 1 to filter only those with multiple full scores.
--   - ORDER BY with Aggregation: Sorted by the count of full score submissions.
-- =========================================================================

SELECT hackers.hacker_id, hackers.name 
from hackers 
join submissions on hackers.hacker_id = submissions.hacker_id 
join challenges on submissions.challenge_id = challenges.challenge_id
join difficulty on challenges.difficulty_level = difficulty.difficulty_level
where 
difficulty.score = submissions.score
group by hackers.hacker_id, hackers.name 
having count(submissions.submission_id) > 1
ORDER by count(submissions.submission_id) DESC, submissions.hacker_id ASC;