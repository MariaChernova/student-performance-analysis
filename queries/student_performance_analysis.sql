-- Question 1: What is the overall average exam score?

SELECT ROUND(AVG(exam_score), 2) as avg_score
FROM SAP;


-- Question 2: Who performs better on average — male or female students?
WITH gender_scores AS (
    SELECT
        gender,
        ROUND(AVG(exam_score), 2) AS avg_score_by_gender
    FROM SAP
    GROUP BY gender
),
overall_avg AS (
    SELECT ROUND(AVG(exam_score), 2) AS overall_avg_score
    FROM SAP
)
SELECT
    gs.gender,
    gs.avg_score_by_gender,
    oa.overall_avg_score
FROM gender_scores as gs
CROSS JOIN overall_avg as oa;

-- Question 3: Does having a tutor affect the exam score?
select tutoring, ROUND(AVG(exam_score), 2) as avg_score
from SAP
group by tutoring;

-- Question 4: How does attendance affect the exam score?
select
case
	WHEN attendance >= 90 then 'High attendance'
	WHEN attendance >= 70 then 'Medium attendance'
	else 'Low attendance'
	END AS attendance_group,
	ROUND(AVG(exam_score), 2) as avg_score
FROM SAP
group by attendance_group;

-- Question 5: What is the student achievement ratio?
select COUNT(student_id) as student_count,
case
	WHEN exam_score >= 90 then 'Excellent'
	WHEN exam_score >= 70 then 'Good'
	WHEN exam_score >= 60 then 'Satisfactory'
	WHEN exam_score >= 50 then 'Poor'
	else 'Fail'
	END AS exam_score_group
FROM SAP
group by exam_score_group
order by student_count DESC;


-- Question 6: What is the difference between student score and overall average?
SELECT
    row_number() OVER () AS student_id,
    exam_score,
    ROUND(exam_score - AVG(exam_score) OVER (), 2) AS diff_overall_avg
FROM   sap
ORDER  BY diff_overall_avg desc;

-- Question 7: How is the student’s average score related to parents' level of education?
SELECT parent_education, COUNT(*) AS students,
       ROUND(AVG(exam_score), 2) AS avg_score
FROM sap
GROUP BY parent_education
ORDER BY avg_score DESC;

-- Question 8: What is the gender ratio?
select gender, COUNT(gender) as count_gender
from sap
group by gender


-- Question 9: What is the correlation between the number of hours taught and the exam score?
SELECT 
    FLOOR(hours_studied_week) AS study_hours,
    ROUND(AVG(exam_score), 2) AS avg_exam_score
FROM SAP
GROUP BY study_hours
ORDER BY study_hours;


-- Question 9. What is the correlation between attendance and test score?
SELECT ROUND(CORR(attendance, exam_score)::numeric, 2) AS r_attendance_vs_score
FROM sap;

-- Question 10. What is the correlation between primary residential environment of the student and test score?
SELECT region, ROUND(AVG(exam_score), 2) AS avg_exam_score
FROM sap
group by region;
