create database sqlpract;
use sqlpract;
1.
create table sales(ord_no int, purch_amt float, ord_date date, customer_id int, salesman_id int);

insert into sales values(70001 ,150.5,'2012-10-05',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.5,'2012-08-17',3009,5003),
(70007,948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.4,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002),
(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.6,'2012-04-25',3002,5001);

select  ord_date,salesman_id,ord_no,purch_amt from sales;


2.
create table salespeople(salesman_id int,name varchar(50),city varchar(50),commission float);

insert into salespeople values(5001,'James Hoog','New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14),
(5007,'Paul Adam','Rome',0.13),
(5003,'Lauson Hen','San Jose',0.12);

select * from salespeople where city='Paris';

3.
create table product(PRO_ID int,PRO_NAME varchar(50),PRO_PRICE float, PRO_COM int);

insert into product values(101,'Motherboard',3200.00,15),
(102,'Keyboard',450.00,16),
(103,'ZIP drive',250.00,14),
(104,'Speaker',550.00,16),
(105,'Monitor',5000.00,11),
(106,'DVD drive',900.00,12),
(107,'CD drive',800.00,12),
(108,'Printer',2600.00,13),
(109,'Refill cartridge',350.00,13),
(110,'Mouse',250.00,12);

select * from product where PRO_PRICE between 200.0 and 600.0;

4.
select PRO_NAME,PRO_PRICE from product where PRO_PRICE>=550;

5.
create table orders(ord_no int, purch_amt float, ord_date date, customer_id int, salesman_id int);
insert into orders values(70001,150.5,'2012-10-05',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.5,'2012-08-17',3009,5003),
(70007,948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.4,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002),
(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.6,'2012-04-25',3002,5001);

select * from orders where ord_date='2012-09-10' and salesman_id>5005 or purch_amt>1000;

6.
create table world (country varchar(50), continent varchar(50),area int, population int, gdp bigint unsigned);
insert into world values('Afghanistan','Asia',652230,25500100,20343000000),
('Albania','Europe',28748,2831741,12960000000),
('Algeria','Africa',2381741,37100000,188681000000),
('Andorra','Europe',468,78115,3712000000),
('Angola','Africa',1246700,20609294,100990000000),
('Dominican Republic','Caribbean',48671,9445281,58898000000),
('China','Asia',9596961,1365370000,8358400000000),
('Colombia','South America',1141748,47662000,369813000000),
('Comoros','Africa',1862,743798,616000000),
('Denmark','Europe',43094,5634437,314889000000),
('Djibouti','Africa',23200,886000,1361000000),
('Dominica','Caribbean',751,71293,499000000);

1.
select country,max(population)from world group by country having max(population)>100000000;
2.
select country,min(gdp) from world group by country having min(gdp)<500000000;

3.
select * from world where country like'%c';

 4.
select * from world where country like 'D%';

5.
select continent,sum(gdp) from world group by continent having sum(gdp) ;

6.
select continent,sum(gdp) from world where continent='Africa';

 7.
 select continent,sum(population) from world group by continent;
 8.
select country,continent,population from world where population<= 200000000;


7. 
create table students(student_id int,
student_name varchar(60) not null,
city varchar(60) not null,
primary key(student_id));
create table course(student_id int,
course_name varchar(60) not null,
Marks int not null,
primary key(student_id),
foreign key(student_id) references students(student_id));
insert into students values(200,'John Doe','Delhi'),
(210,'John Doe','Delhi'),
(220,'Moon ethan','Rajasthan'),
(230,'Jessie','Bangalore'),
(240,'Benbrook','Bihar'),
(250,'Ethan','Bihar'),
(260,'Johnnie','Bangalore'),
(270,'Goh','Delhi'),(380,'John Doe','Delhi'),
(280,'Pavi','Delhi'),
(290,'Sanvi','Rajasthan'),
(300,'Navyaa','Bangalore'),
(310,'Ankul','Bihar'),
(311,'Hitanshi','Bihar'),
(312,'Aayush','Bangalore'),
(313,'Rian','Delhi');
insert into course values(200,'Datascience',75),
(210,'Datascience',75),
(220,'Dataanalyst',80),
(230,'Dataanalyst',80),
(240,'Dataanalyst',84),
(250,'Dataanalyst',50),
(260,'Datascience',80),
(270,'Datascience',99),
(380,'Datascience',45),
(280,'Datascience',78),
(290,'Dataanalyst',78),
(300,'Computer vision',90),
(310,'Computer vision',90),
(311,'Computer vision',75),
(312,'Computer vision',39);

q1. write a query to fetch the names of the students having maximum marks in each course?
select s.student_name,c.course_name,max(c.marks)
from students s inner join course c on
s.student_id=c.student_id group by c.course_name order by max(c.marks) desc; 



q2. write a query to fetch the names of the students having 3th highest marks from each course?
select s.*,c.*
from
(select student_id,course_name,marks, row_number() over(partition by course_name order by marks desc) as third_highest_mark from course  group by course_name,marks)c
inner join (select student_id,student_name,row_number() over(partition by student_id) as st from students group by student_id)s
on c.student_id=s.student_id where c.third_highest_mark=3; 

q3. write a query to fetch the names of the students having minimum marks in each course?
select s.*,c.*
from
(select student_id,course_name,marks, row_number() over(partition by course_name order by marks) as minimum_mark from course  group by course_name,marks)c
inner join (select student_id,student_name,row_number() over(partition by student_id) as st from students group by student_id)s
on c.student_id=s.student_id where c.minimum_mark=1; 



q4. write a query to fetch the names of the students having 4th least marks from each course
select s.*,c.*
from
(select student_id,course_name,marks, row_number() over(partition by course_name order by marks desc) as fourth_least_mark from course  group by course_name,marks)c
inner join (select student_id,student_name,row_number() over(partition by student_id) as st from students group by student_id)s
on c.student_id=s.student_id where c.fourth_least_mark=4;

q5. write a query to fetch the city name of the students who have 2nd highest marks?

select s.student_id,s.city,c.marks
from
(select *, row_number() over(partition by course_name order by marks desc) as second_highest_mark from course  group by course_name,marks)c
inner join (select *,row_number() over(partition by student_id) as st from students group by student_id)s
on c.student_id=s.student_id where c.second_highest_mark=2;



q6. write a query to fetch the count of each city?
select count(city) as count_of_each_city from students;

q7. write a query to fetch the names of the students who are from the same city?

select city, GROUP_CONCAT(student_name) as students_from_same_city from students group by city;

q8.write a query to fetch the names of students starting with 'A'?
select student_name from students where student_name like'A%';

q9.write a query to fetch the count of students' names having the same marks in each course'?

select count(s.student_name) as count_of_students,c.marks,count(c.marks) as count_marks,c.course_name from students s
inner join course c on
s.student_id=c.student_id
group by c.marks,c.course_name having count_marks>=2;

q10.write a query to fetch the count of students from each city?
select count(student_name),city from students group by city;


8.
create table activity(player_id int,device_id int,event_date date,games_played int);

insert into activity values(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

select a.player_id,a.event_date as first_login
from
(select *, row_number()over(partition by player_id order by event_date) as first_login from activity)a
where a.first_login=1;


9.

create table products(product_id int,low_fats enum('Y','N'),recyclable enum('Y','N'));

insert into products values(0,'Y','N'),(1,'Y','Y'),(2,'N','Y'),(3,'Y','Y'),(4,'N','N');

select product_id from products where low_fats='Y' and recyclable='Y';

10.
create table world1 (`name` varchar(50), `region` varchar(50),area int, population int, gdp bigint unsigned null);
insert into world1 values('Afghanistan','South Asia', 652225,26000000,null),('Albania','Europe',28728,3200000,6656000000),
('Algeria','Middle East',2400000,32900000,75012000000),('Andorra','Europe',468,64000,null);

1.Select the statement that shows the sum of population of all countries
select `name`,sum(population) from world1 group by `name`;

2.Select the statement that shows the number of countries with population smaller than 150000

select `name`,population from world1 where population<=150000 group by `name`;

3.Select the list of core SQL aggregate functions
select `name`,min(population) from world1 group by `name` having min(population)<70000 order by `name`;
select `name`,max(population) from world1 group by `name` having max(population)>30000000;
select `name`,gdp from world1  where gdp is not null group by `name`;

7. Select the statement that shows the name and population density of the country with the largest population

select 
  `name`, population, gdp, area, 
  case coalesce(area, 0) 
    when 0 then null 
    else population / area 
  end as pop_density 
from world1
order by gdp; 
