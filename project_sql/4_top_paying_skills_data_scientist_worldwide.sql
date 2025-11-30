/*
Question: What are the highest-paying skills for Data Scientists?
Goal: Find the top 25 skills associated with the highest average salaries.
Method:
      1. Select Data Scientist job postings with valid salary data.
      2. Join skills and job tables to link skills to postings.
      3. Calculate the average salary per skill and sort by highest pay.
*/


SELECT 
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
      salary_year_avg IS NOT NULL
GROUP BY    
      skills_dim.skills
ORDER BY
      avg_salary DESC
LIMIT 25


/*
Here's a breakdown of the results for top paying skills for data scientists:
-Leadership & cross-functional roles pay the most — tools like Asana, Airtable, Slack, Notion, and Atlassian near the top suggest high salaries are concentrated in senior or hybrid data science roles that involve coordination, product alignment, and team leadership.
-Niche or specialized technical skills earn a premium — rare languages and ecosystems (Elixir, Haskell, Lua, Objective-C, Solidity, Ruby on Rails) show high pay due to limited talent pools and critical legacy or specialized systems.
-Production-focused ML and cloud skills remain highly compensated — tools like Airflow, BigQuery, DynamoDB, Watson, and Hugging Face highlight strong demand for data scientists who can build, deploy, and maintain real-world ML pipelines at scale.


[
  {
    "skills": "asana",
    "avg_salary": "215477"
  },
  {
    "skills": "airtable",
    "avg_salary": "201143"
  },
  {
    "skills": "redhat",
    "avg_salary": "189500"
  },
  {
    "skills": "watson",
    "avg_salary": "187417"
  },
  {
    "skills": "elixir",
    "avg_salary": "170824"
  },
  {
    "skills": "lua",
    "avg_salary": "170500"
  },
  {
    "skills": "slack",
    "avg_salary": "168219"
  },
  {
    "skills": "solidity",
    "avg_salary": "166980"
  },
  {
    "skills": "ruby on rails",
    "avg_salary": "166500"
  },
  {
    "skills": "rshiny",
    "avg_salary": "166436"
  },
  {
    "skills": "notion",
    "avg_salary": "165636"
  },
  {
    "skills": "objective-c",
    "avg_salary": "164500"
  },
  {
    "skills": "neo4j",
    "avg_salary": "163971"
  },
  {
    "skills": "dplyr",
    "avg_salary": "163111"
  },
  {
    "skills": "hugging face",
    "avg_salary": "160868"
  },
  {
    "skills": "dynamodb",
    "avg_salary": "160581"
  },
  {
    "skills": "haskell",
    "avg_salary": "157500"
  },
  {
    "skills": "unity",
    "avg_salary": "156881"
  },
  {
    "skills": "airflow",
    "avg_salary": "155878"
  },
  {
    "skills": "codecommit",
    "avg_salary": "154684"
  },
  {
    "skills": "unreal",
    "avg_salary": "153278"
  },
  {
    "skills": "theano",
    "avg_salary": "153133"
  },
  {
    "skills": "zoom",
    "avg_salary": "151677"
  },
  {
    "skills": "bigquery",
    "avg_salary": "149292"
  },
  {
    "skills": "atlassian",
    "avg_salary": "148715"
  }
]
*/
