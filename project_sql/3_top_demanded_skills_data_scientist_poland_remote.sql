/*
Question: What are the most in-demand skills for Data Scientists?
Goal: Identify the top 5 skills required for Data Scientist jobs in Poland or remotely to guide learning focus.
Method:
    1. Filter job postings for 'Data Scientist' positions located in 'Poland' OR 'Anywhere' (Remote).
    2. Group by skill name and count the number of job postings for each skill.
    3. Order by demand count in descending order to find the most popular skills.
*/


SELECT 
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
      (job_location = 'Poland' OR job_location = 'Anywhere')
GROUP BY
      skills_dim.skill_id
ORDER BY
      demand_count DESC
LIMIT 5

