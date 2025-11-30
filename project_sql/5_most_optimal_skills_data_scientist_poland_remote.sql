/*
Question: Which skills for Data Scientists in Poland (or remote) are both well-paid and in high demand?
Goal: Find the top skills that combine strong job demand with high average yearly salary.
Method:
– Count how often each skill appears in relevant job postings.
– Calculate the average salary associated with each skill.
– Merge both metrics, filter skills with sufficient demand, and rank by highest salary.
*/




WITH skills_demand AS(
SELECT 
      skills_dim.skill_id,
      skills_dim.skills,
      COUNT(skills_job_dim.job_id) AS demand_count
FROM
      skills_job_dim
LEFT JOIN skills_dim
      ON skills_dim.skill_id = skills_job_dim.skill_id
LEFT JOIN job_postings_fact
      ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE
      job_title_short = 'Data Scientist' AND
      salary_year_avg IS NOT NULL AND
      (job_location = 'Poland' OR job_location = 'Anywhere')
GROUP BY
      skills_dim.skill_id,
      skills_dim.skills
), average_salary AS (
    SELECT 
      skills_job_dim.skill_id,
      skills_dim.skills,
      ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
      skills_job_dim
LEFT JOIN skills_dim
      ON skills_dim.skill_id = skills_job_dim.skill_id
LEFT JOIN job_postings_fact
      ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE
      job_title_short = 'Data Scientist' AND
      salary_year_avg IS NOT NULL AND
      (job_location = 'Poland' OR job_location = 'Anywhere')
GROUP BY    
      skills_job_dim.skill_id,
      skills_dim.skills
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25


