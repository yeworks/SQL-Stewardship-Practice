-- =========================================================================
-- [HackerRank] The Report (Medium)
-- Objective: Generate a report containing Name, Grade, and Mark, filtering out names for grades lower than 8.
-- Technical Focus:
--   - Non-Equi Join: Used 'BETWEEN' operator to join Students and Grades tables based on a range of marks.
--   - IF Function: Replaced bulky CASE statements with a single-line IF condition to output "NULL" for grades < 8.
--   - Multiple Sorting: Applied ORDER BY with multiple columns (Grade DESC, Name ASC).
-- =========================================================================

SELECT  
if (Grades.grade < 8 ,"NULL",students.name), Grades.grade, students.marks
from students
join Grades on students.marks between Grades.Min_Mark and Grades.Max_Mark 
order by Grades.grade DESC, students.name ASC;
