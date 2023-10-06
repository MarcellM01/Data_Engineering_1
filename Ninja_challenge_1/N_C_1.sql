DROP TABLE IF EXISTS employee_data;
CREATE TABLE employee_data (
    id INT,
    employee_name VARCHAR(255),
    department VARCHAR(255),
    salary double,
primary key(id));

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ceu-economics-and-business.github.io_ECBS-5146-Different-Shapes-of-Data_artifacts_intro_ninja.txt'
INTO TABLE employee_data
FIELDS TERMINATED BY ','
LINES STARTING BY 'Data:'
(@id, @employee_name, @department, @salary)
SET
    id = @id,
    employee_name = replace(@employee_name, '"', ''),
    department = @department,
    salary = @salary / 1000;
    
select * from employee_data;




