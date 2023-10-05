-- HomeWork 1

-- Question 1: Based on the previous chapter, create a table called “employee” with two columns: “id” and “employee_name”. NULL values should not be accepted for these 2 columns.

Use birdstrikes;
CREATE TABLE EMPLOYEE(
id int not null,
employee_name VARCHAR(255) not null,
primary key(id));

-- Question 2: What state figures in the 145th line of our database?

select state from birdstrikes limit 149,1;

-- Question 3: What is flight_date of the latest birstrike in this database?

select flight_date from birdstrikes order by flight_date desc limit 1,1;

-- Question 4: What was the cost of the 50th most expensive damage?

select cost from birdstrikes order by cost desc limit 49,1;

-- Question 5: What state figures in the 2nd record, if you filter out all records which have no state and no bird_size specified?

select state from birdstrikes where state is not null and state !='' and bird_size is not null and bird_size !='' limit 1,1;

-- Question 6: How many days elapsed between the current date and the flights happening in week 52, for incidents from Colorado? 
-- (Hint: use NOW, DATEDIFF, WEEKOFYEAR)

select datediff(Now(), flight_date) as days_elapsed from birdstrikes where weekofyear(flight_date) = 52 and state = 'Colorado';