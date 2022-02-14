-- Combine data from Employee & Title tables and join them. 

SELECT DISTINCT e.emp_no, e.first_name, e.last_name, e.hire_date, title, from_date, to_date, e.birth_date
INTO retirement_titles
From "Employees" as e
Inner Join "Titles" as t on e.emp_no = t.emp_no
WHERE e.birth_date >= '01/01/1952' and e.birth_date <= '12/31/1955'
ORDER BY e.birth_date DESC;

--Set some alias into a temp table.
SELECT r.emp_no,
	r.first_name,
	r.last_name,
	r.title,
	r.hire_date,
	r.to_date,
	r.birth_date
INTO temp_titles
from "retirement_titles" as r
INNER JOIN employees_titles as e
ON r.emp_no = e.emp_no;

-- Begin starter code: Use Dictinct with Orderby to remove duplicate rows from retirement tble.
SELECT DISTINCT ON (emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM temp_titles
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (to_date = '9999-01-01')
ORDER BY emp_no, hire_date DESC;

--RETRIEVE TOTAL NUMBER OF TITLES FROM UNIQUE
SELECT COUNT (title)
FROM unique_titles as u
ORDER BY u.title;

--CREATE RETIRING TITLES TABLE
SELECT COUNT (u.emp_no), r.title
INTO retiring_titles
FROM unique_titles as u
INNER JOIN retirement_titles as r
ON u.emp_no = r.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (to_date = '9999-01-01')
GROUP BY r.title
ORDER BY COUNT(u.emp_no) DESC;
--QUERY TO SEE TABLE CONTENT
SELECT * FROM retiring_titles
--QUERY TO DELETE ENTIRE TABLE
DROP TABLE retiring_titles

--CREATE MENTORSHIP ELIGIBILITY TABLE FOR 1965
SELECT DISTINCT ON (e.emp_no)
    e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM "Employees" as e
INNER JOIN "Dept_emp" as de
    ON e.emp_no = de.emp_no
INNER JOIN "Titles" as t
    ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no
-- CHECK TABLE
SELECT * FROM mentorship_eligibility