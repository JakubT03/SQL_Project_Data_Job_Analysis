# Introduction
This project analyzes the Data Science job market. I focused on comparing jobs in Poland with Remote work opportunities globally.

I used real job data to check salaries and required skills. I wanted to see if it is better to look for a job locally in Poland or to work remotely for international companies.
# Background
I created this project to better understand the Data Science job market. I specifically wanted to compare local opportunities in Poland with remote work to find the best career path for myself.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying Data Scientist jobs in Poland vs. Remote?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for Data Scientists (in Poland and remotely)?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn (high demand + high salary)?
# Tools I Used
To analyze the data, I used these tools:

* SQL: To write queries and filter the data.

* PostgreSQL: The database system I used.

* Visual Studio Code: The program where I wrote my code.

* Git & GitHub: To save my work and share it.
# The Analysis
I created 5 SQL queries to answer my questions. Here is what I did:

1. Top Paying Jobs: Poland vs. Remote
I compared the top 7 highest-paying Data Science jobs in Poland with the top 7 remote jobs.

* Goal: To see the salary difference between local and global markets.

* Analysis: Remote opportunities usually offer higher salaries, but local market offers stability.
```sql
-- Comparison of Top 7 Job Postings: Poland vs Remote
(
    SELECT
        name AS company_name,
        job_title,
        job_location,
        salary_year_avg
    FROM   
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
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
        job_title,
        job_location,
        salary_year_avg
    FROM    
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id        
    WHERE
        job_title_short LIKE 'Data Scientist' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 7
)
ORDER BY
    salary_year_avg DESC;
```
2. Skills for Top Paying Jobs
I checked what specific skills are required for these top jobs.

* Key Findings: SQL and Python are the foundation. Cloud tools (Azure, AWS) are essential for top salaries.

```sql
WITH top_paying_data_scientist_jobs AS (
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
```

3. Most In-Demand Skills
I looked for the most popular skills for Data Scientists in Poland and Remote jobs.

* Goal: To find the skills that give the best chance of getting hired.

```sql
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
```

4. Highest Paying Skills
I calculated the average salary for different skills to see which ones pay the most.

* Insight: Specialized skills (like Solidity or Elixir) often pay more than popular general skills.

```sql
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
```

5. Optimal Skills
I looked for the "perfect" skills. These are skills that are both in high demand AND pay well.

* Strategy: I filtered for skills that appear in at least 10 job offers and ranked them by salary.

```sql
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
```
# What I Learned
During this project, I improved my SQL skills and learned about the industry:

* SQL Skills: I learned how to use complex queries (CTEs) and how to group data effectively.

* Market Insight: I learned that general skills (like SQL) are good for finding a job, but specialized skills are better for finding a high-paying job.
# Conclusions
Here are my main takeaways from the analysis:

1.Leadership skills pay well: Tools like Asana, Notion, and Slack have high average salaries. This means senior roles (managers) earn the most.

2.Special skills are valuable: Rare technologies (like Solidity or Elixir) pay a lot because few people know them.

3.Cloud skills are essential: Companies pay well for skills like Airflow and BigQuery. They need people who can work with data in the cloud.

4.The Basics: Even though rare skills pay well, you simply cannot work in Data Science without SQL and Python. They are the foundation.


### Insights
From the analysis, I found these key points:

1.  **Remote Jobs Pay More:** Remote work offers much higher salaries than local jobs in Poland. The best remote job pays **$550,000**, while the best job in Poland pays about **$187,000**.
2.  **Skills for Top Jobs:** To earn a lot of money, you need more than just coding. **SQL and Python** are basic requirements, but top jobs also need **Cloud skills** (like Azure, Snowflake) and data visualization (Tableau).
3.  **Most Popular Skills:** **Python and SQL** are the most popular skills. Companies in Poland and globally ask for them the most.
4.  **Special Skills = High Salary:** The highest salaries are for rare skills (like Solidity) or leadership tools (like Asana, Notion). This means managers and specialists earn the most.
5.  **Best Skills to Learn:** **SQL and Python** are the best choice. They are in high demand and offer good salaries. They are the safest skills to start a career in Data Science.

### Closing Thoughts
This project improved my SQL skills and gave me a better understanding of the Data Scientist job market.

The results serve as a guide for me and other job seekers. I found that while remote jobs pay the highest salaries, SQL and Python are the most important skills everywhere (both in Poland and globally). To earn more money, it is worth learning cloud tools and leadership skills. This analysis shows that we must keep learning to be successful in the data industry.