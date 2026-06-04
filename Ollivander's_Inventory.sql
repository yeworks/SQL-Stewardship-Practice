-- =========================================================================
-- [HackerRank] Ollivander's Inventory (Medium)
-- Objective: Help Harry find the cheapest wands for each unique combination of age and power.
-- Technical Focus:
--   - Correlated Subquery: Used a subquery that references the outer query (w2.code = w.code) to find the minimum price per group.
--   - 1:1 Mapping Optimization: Leveraged the 1:1 relationship between code and age, using 'code' in the subquery to automatically filter by 'age'.
--   - Non-Evil Filtering: Excluded evil wands using is_evil = 0.
-- =========================================================================

SELECT w.id, p.age, w.coins_needed, w.power from wands w
join wands_property p on w.code = p.code 
where p.is_evil = 0 
  and w.coins_needed 
    =(SELECT min(w2.coins_needed) from wands w2
    join wands_property p2 on w2.code = p2.code
    where w.power = w2.power and p.age = p2.age)
ORDER by power DESC, age DESC;