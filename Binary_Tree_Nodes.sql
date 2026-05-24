-- =========================================================================
-- [HackerRank] Binary Tree Nodes (Medium)
-- Objective: Determine the type of each node (Root, Leaf, Inner) in a Binary Tree.
-- Technical Focus:
--   - Implemented conditional logic using CASE WHEN statements.
--   - Managed subqueries within IN clauses.
--   - Handled NULL values safely in subqueries to prevent UNKNOWN logic errors.
-- =========================================================================

SELECT n,
case
 when p is null then 'Root'
 when n in (SELECT p from BST where p is not null) then 'Inner'
 else 'Leaf'
end
from BST
ORDER by n;
