/*
Question: What skills are required for the top-paying data scientist jobs?
Goal: To create a consolidated list of technologies per company, helping to tailor job applications and study paths.
*/


WITH top_paying_data_scientist_jobs AS (
(
    -- STEP 1: Top 7 Job Postings from Poland
    SELECT
        name AS company_name,
        job_id,
        job_title,
        job_location,
        salary_year_avg
    FROM   
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short LIKE 'Data Scientist' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Poland'
    ORDER BY
        salary_year_avg DESC
    LIMIT 7
)

UNION ALL 

(
    SELECT
        name AS company_name,
        job_id,
        job_title,
        job_location,
        salary_year_avg
    FROM    
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id        
    WHERE
        job_title_short LIKE 'Data Scientist' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 7
)
ORDER BY
    salary_year_avg DESC
)
SELECT
    company_name,
    job_title,
    job_location,
    salary_year_avg,
    skills_dim.skills
FROM top_paying_data_scientist_jobs
INNER JOIN skills_job_dim
    ON  top_paying_data_scientist_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY    
    salary_year_avg DESC;

/*
-SQL is needed in 8 jobs

-Python is needed in 6 jobs

-Tableau is needed in 5 jobs

-Azure is needed in 4 jobs

-Scikit-learn is needed in 3 jobs

-PyTorch, GCP, R, Snowflake, Databricks, AWS, Spark, TensorFlow are needed in 2 jobs

-Keras, Java, Theano, MXNet, Scala, Windows, BigQuery, Git, Cassandra, Looker, Power BI,
Airflow, Hadoop, DataRobot, Pandas are needed in 1 job

[
  {
    "company_name": "Selby Jennings",
    "job_title": "Staff Data Scientist/Quant Researcher",
    "job_location": "Anywhere",
    "salary_year_avg": "550000.0",
    "skills": "sql"
  },
  {
    "company_name": "Selby Jennings",
    "job_title": "Staff Data Scientist/Quant Researcher",
    "job_location": "Anywhere",
    "salary_year_avg": "550000.0",
    "skills": "python"
  },
  {
    "company_name": "Selby Jennings",
    "job_title": "Staff Data Scientist - Business Analytics",
    "job_location": "Anywhere",
    "salary_year_avg": "525000.0",
    "skills": "sql"
  },
  {
    "company_name": "Algo Capital Group",
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "salary_year_avg": "375000.0",
    "skills": "sql"
  },
  {
    "company_name": "Algo Capital Group",
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "salary_year_avg": "375000.0",
    "skills": "python"
  },
  {
    "company_name": "Algo Capital Group",
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "salary_year_avg": "375000.0",
    "skills": "java"
  },
  {
    "company_name": "Algo Capital Group",
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "salary_year_avg": "375000.0",
    "skills": "cassandra"
  },
  {
    "company_name": "Algo Capital Group",
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "salary_year_avg": "375000.0",
    "skills": "spark"
  },
  {
    "company_name": "Algo Capital Group",
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "salary_year_avg": "375000.0",
    "skills": "hadoop"
  },
  {
    "company_name": "Algo Capital Group",
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "salary_year_avg": "375000.0",
    "skills": "tableau"
  },
  {
    "company_name": "Teramind",
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "salary_year_avg": "320000.0",
    "skills": "azure"
  },
  {
    "company_name": "Teramind",
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "salary_year_avg": "320000.0",
    "skills": "aws"
  },
  {
    "company_name": "Teramind",
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "salary_year_avg": "320000.0",
    "skills": "tensorflow"
  },
  {
    "company_name": "Teramind",
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "salary_year_avg": "320000.0",
    "skills": "keras"
  },
  {
    "company_name": "Teramind",
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "salary_year_avg": "320000.0",
    "skills": "pytorch"
  },
  {
    "company_name": "Teramind",
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "salary_year_avg": "320000.0",
    "skills": "scikit-learn"
  },
  {
    "company_name": "Teramind",
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "salary_year_avg": "320000.0",
    "skills": "datarobot"
  },
  {
    "company_name": "State Street",
    "job_title": "Corporate Audit, AVP – Full Stack Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "186928.0",
    "skills": "sql"
  },
  {
    "company_name": "State Street",
    "job_title": "Corporate Audit, AVP – Full Stack Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "186928.0",
    "skills": "azure"
  },
  {
    "company_name": "State Street",
    "job_title": "Corporate Audit, AVP – Full Stack Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "186928.0",
    "skills": "databricks"
  },
  {
    "company_name": "State Street",
    "job_title": "Corporate Audit, AVP – Full Stack Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "186928.0",
    "skills": "aws"
  },
  {
    "company_name": "State Street",
    "job_title": "Corporate Audit, AVP – Full Stack Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "186928.0",
    "skills": "snowflake"
  },
  {
    "company_name": "State Street",
    "job_title": "Corporate Audit, AVP – Full Stack Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "186928.0",
    "skills": "tableau"
  },
  {
    "company_name": "Palta",
    "job_title": "Analytics Engineer",
    "job_location": "Poland",
    "salary_year_avg": "158500.0",
    "skills": "sql"
  },
  {
    "company_name": "Palta",
    "job_title": "Analytics Engineer",
    "job_location": "Poland",
    "salary_year_avg": "158500.0",
    "skills": "python"
  },
  {
    "company_name": "Palta",
    "job_title": "Analytics Engineer",
    "job_location": "Poland",
    "salary_year_avg": "158500.0",
    "skills": "snowflake"
  },
  {
    "company_name": "Palta",
    "job_title": "Analytics Engineer",
    "job_location": "Poland",
    "salary_year_avg": "158500.0",
    "skills": "airflow"
  },
  {
    "company_name": "Palta",
    "job_title": "Analytics Engineer",
    "job_location": "Poland",
    "salary_year_avg": "158500.0",
    "skills": "tableau"
  },
  {
    "company_name": "Palta",
    "job_title": "Analytics Engineer",
    "job_location": "Poland",
    "salary_year_avg": "158500.0",
    "skills": "power bi"
  },
  {
    "company_name": "Palta",
    "job_title": "Analytics Engineer",
    "job_location": "Poland",
    "salary_year_avg": "158500.0",
    "skills": "looker"
  },
  {
    "company_name": "Opera",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "157500.0",
    "skills": "sql"
  },
  {
    "company_name": "Opera",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "157500.0",
    "skills": "git"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (S&OP)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "sql"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (S&OP)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "r"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (S&OP)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "gcp"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (S&OP)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "spark"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (S&OP)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "tableau"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (Data Science Hub)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "sql"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (Data Science Hub)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "python"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (Data Science Hub)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "bigquery"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (Data Science Hub)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "gcp"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (Data Science Hub)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "windows"
  },
  {
    "company_name": "Allegro",
    "job_title": "Data Scientist (Data Science Hub)",
    "job_location": "Poland",
    "salary_year_avg": "132500.0",
    "skills": "tableau"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "python"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "scala"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "r"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "azure"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "tensorflow"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "pytorch"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "scikit-learn"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "mxnet"
  },
  {
    "company_name": "EY",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "123064.0",
    "skills": "theano"
  },
  {
    "company_name": "HEINEKEN",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "121000.0",
    "skills": "python"
  },
  {
    "company_name": "HEINEKEN",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "121000.0",
    "skills": "azure"
  },
  {
    "company_name": "HEINEKEN",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "121000.0",
    "skills": "databricks"
  },
  {
    "company_name": "HEINEKEN",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "121000.0",
    "skills": "pandas"
  },
  {
    "company_name": "HEINEKEN",
    "job_title": "Data Scientist",
    "job_location": "Poland",
    "salary_year_avg": "121000.0",
    "skills": "scikit-learn"
  }
]
*/