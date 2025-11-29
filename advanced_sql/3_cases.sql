SELECT
    job_id,
    salary_year_avg,
    CASE
    WHEN salary_year_avg < 60000 THEN 'low_salary'
     WHEN salary_year_avg BETWEEN 60000 AND 120000 THEN 'standard_salary'
    ELSE 'high_salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC

