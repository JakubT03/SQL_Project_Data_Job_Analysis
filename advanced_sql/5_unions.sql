WITH quarter1_job_postings AS (
SELECT *
FROM january_jobs

UNION ALL

SELECT *
FROM february_jobs

UNION ALL

SELECT *
FROM march_jobs
)
SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    skills_dim.skills,
    skills_dim.type,
    salary_year_avg
FROM
    quarter1_job_postings
LEFT JOIN skills_job_dim
    ON quarter1_job_postings.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC    

       


