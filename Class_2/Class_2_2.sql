use birdstrikes;

select count(*) from birdstrikes;

select count(reported_date) from birdstrikes;

select distinct state from birdstrikes;

select count(distinct state) from birdstrikes;

select count(distinct aircraft) from birdstrikes;

select sum(cost) from birdstrikes;

select (avg(speed)*1.852) as avg_kmh from birdstrikes;

select datediff(max(reported_date), min(reported_date)) from birdstrikes;

select max(reported_date) from birdstrikes;
select min(reported_date) from birdstrikes;

select min(speed), aircraft from birdstrikes where aircraft like "H%";

-- Groupby

select max(speed), aircraft from birdstrikes group by aircraft;

select state, aircraft from birdstrikes where state !='' group by state, aircraft order by state;

select state, aircraft, sum(cost) as sum 
	from birdstrikes where state !=''
    group by state, aircraft
    order by sum desc;

-- Exercise 4: Which phase_of_flight has the least of incidents?

select phase_of_flight, count(id) from birdstrikes group by phase_of_flight order by count(id);

-- Exercise 5

select phase_of_flight, round(avg(cost), 0) as r_avg from birdstrikes group by phase_of_flight order by r_avg desc;

SELECT AVG(speed) AS avg_speed,state FROM birdstrikes GROUP BY state HAVING ROUND(avg_speed) = 50;

select state, avg(speed) as avg_speed from birdstrikes group by state having length(state) < 5 order by avg_speed desc;


