CREATE Schema employee;

create table employee(
id int auto_increment primary key,
employee_name VARCHAR(255) NOT NULL
);

select * from employee;

INSERT INTO employee (id,employee_name) VALUES(1,'Student1');
INSERT INTO employee (id,employee_name) VALUES(2,'Student2');
INSERT INTO employee (id,employee_name) VALUES(3,'Student3');

SELECT * FROM employee;

INSERT INTO employee (id,employee_name) VALUES(3,'Student4');

SELECT * FROM employee;

UPDATE employee SET employee_name='Arnold Schwarzenegger' WHERE id = '1';
UPDATE employee SET employee_name='The Other Arnold' WHERE id = '2';




