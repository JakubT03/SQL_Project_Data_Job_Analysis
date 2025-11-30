/*
Question: Compare Top 7 Job Postings from Poland vs Top 7 Remote Job Postings.
Goal: Visualize the "salary ceiling" in both categories, highlighting the differences between local and global markets.
*/


(
    -- STEP 1: Top 7 Job Postings from Poland
    SELECT
        name AS company_name,
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

UNION ALL -- Combine results

(
    -- STEP 2: Top 7 Remote Job Postings
    SELECT
        name AS company_name,
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
    -- STEP 3: Order the combined list to demonstrate the disparity between local and global salaries
ORDER BY
    salary_year_avg DESC