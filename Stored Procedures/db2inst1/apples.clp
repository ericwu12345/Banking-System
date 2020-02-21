-- Student ID: 011983517
-- Wu, Eric,
-- In order to run this sql script with the ^ as your line delimiter, use the follow command options
-- db2 -td"^" -f hw3.clp
connect to cs157a^
drop table hw3.class^
drop table hw3.classreq^
create table hw3.class(classid varchar(5) not null, name varchar(30), desc varchar(30), primary key(classid))^
create table hw3.classreq(classid varchar(5), prereqid varchar(5), coreq char(1), foreign key(classid) references hw3.class(classid) on delete cascade)^
insert into hw3.class values ( '10000', 'CS46A', 'Intro to Prog' )^
insert into hw3.class values ( '10001', 'CS46B', 'Intro to Data Str' )^
insert into hw3.class values ( '10002', 'CS47', 'Intro to Comp Sys' )^
insert into hw3.class values ( '10003', 'CS49J', 'Java Prog' )^
insert into hw3.class values ( '20000', 'CS146', 'Data Str & Algorithm' )^
insert into hw3.class values ( '20001', 'CS157A', 'Intro to DBMS' )^
insert into hw3.class values ( '30000', 'MATH46', 'Another math class' )^
insert into hw3.classreq values ( '10001', '10000', 'F' )^
insert into hw3.classreq values ( '10001', '10003', 'F' )^
insert into hw3.classreq values ( '10001', '30000', 'T' )^
insert into hw3.classreq values ( '10002', '10001', 'F' )^
insert into hw3.classreq values ( '20000', '10001', 'F' )^
insert into hw3.classreq values ( '20001', '20000', 'F' )^
insert into hw3.student values ( '22222', 'Alan', 'Turing')^
insert into hw3.student values ( '22222', 'Alan', 'Turing')^
insert into hw3.student values ( '22225', 'Bob', 'Cat')^
insert into hw3.schedule values ( '22222', '10001', 'S', '2014' )^
insert into hw3.schedule values ( '22222', '30000', 'F', '2014' )^
insert into hw3.schedule values ( '22222', '10001', 'S', '2015' )^
insert into hw3.schedule values ( '22222', '10000', 'F', '2015' )^
insert into hw3.schedule values ( '22222', '10001', 'S', '2016' )^
insert into hw3.schedule values ( '22222', '10002', 'F', '2016' )^
insert into hw3.schedule values ( '22222', '20001', 'S', '2017' )^
insert into hw3.schedule values ( '22222', '20000', 'F', '2017' )^
insert into hw3.schedule values ( '22222', '20001', 'S', '2018' )^

