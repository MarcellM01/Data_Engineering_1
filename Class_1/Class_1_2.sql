CREATE USER 'marcellmagda'@'%' IDENTIFIED BY 'marcellmagda1';
GRANT ALL ON birdstrikes.employee TO 'marcellmagda'@'%';

GRANT SELECT (state) ON birdstrikes.birdstrikes TO 'marcellmagda'@'%';

select *, speed/2 as halfspeed from birdstrikes.birdstrikes;

use birdstrikes;
select * from birdstrikes limit 10;

select * from birdstrikes limit 10,1;

select state from birdstrikes limit 144,1;

SELECT state, cost FROM birdstrikes ORDER BY cost desc;

SELECT reported_date FROM birdstrikes ORDER BY reported_date desc;

SELECT flight_date FROM birdstrikes ORDER BY flight_date desc;

select distinct damage from birdstrikes;

select distinct airline, state from birdstrikes order by airline;

select distinct cost from birdstrikes order by cost desc limit 49,1;

SELECT * FROM birdstrikes WHERE state != 'Alabama';

SELECT DISTINCT state FROM birdstrikes WHERE state NOT LIKE 'a%';

Select * from birdstrikes where state='Alabama' and bird_size='Small';

Select * from birdstrikes where state='Alabama' or state='Texas';

Select * from birdstrikes where state is not null and state !='' order by state;

Select * from birdstrikes where state in ('Alabama', 'Texas', 'New York');

select distinct state from birdstrikes where length(state)=5;

-- What state figures in the 2nd record, if you filter out all records which have no state and no bird_size specified?

select state from birdstrikes where state is not null and state !='' and bird_size is not null and bird_size !='' limit 1,1;

select * from birdstrikes where speed = 350;

select round(sqrt(speed/2)*10) as synthetic_speed from birdstrikes;

SELECT * FROM birdstrikes where cost BETWEEN 20 AND 40;

SELECT * FROM birdstrikes WHERE flight_date = "2000-01-02";

SELECT * FROM birdstrikes WHERE flight_date >= '2000-01-01' AND flight_date <= '2000-01-03';


-- How many days elapsed between the current date and the flights happening in week 52, 
-- for incidents from Colorado? (Hint: use NOW, DATEDIFF, WEEKOFYEAR)

-- flights happening in week 52
-- Colorado

select * from birdstrikes where incident_date;

SELECT DATEDIFF(flight_date, now()) AS days_elapsed FROM birdstrikes WHERE WEEKOFYEAR(flight_date) = 52 AND state = 'Colorado';

select flight_date from birdstrikes where WEEKOFYEAR(flight_date) = 52;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 'ON';
SHOW GLOBAL VARIABLES LIKE 'local_infile';










