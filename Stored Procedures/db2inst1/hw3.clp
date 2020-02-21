connect to cs157a^
drop table hw3.class^
drop table hw3.classreq^
drop table hw3.student^
drop table hw3.schedule^
drop trigger check_requisites^
create table hw3.student(id varchar(5) not null, first varchar(10) not null, last varchar(20) not null, primary key(id))^
create table hw3.class(classid varchar(5) not null, name varchar(30), desc varchar(30), primary key(classid))^
create table hw3.classreq(classid varchar(5), prereqid varchar(5), coreq char(1), foreign key(classid) references hw3.class(classid) on delete cascade)^
create table hw3.schedule(studentid varchar(5) not null, classid varchar(5) not null, semester char(1), year int, foreign key(studentid) references hw3.student(id), foreign key(classid) references hw3.class(classid) on delete cascade)^

create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic  If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'F') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End^
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
--insert into hw3.schedule values ( '22222', '10000', 'S', '2014' )^
insert into hw3.schedule values ( '22222', '10001', 'S', '2014' )^
insert into hw3.schedule values ( '22222', '30000', 'S', '2014' )^
insert into hw3.schedule values ( '22222', '10001', 'M', '2014' )^
insert into hw3.schedule values ( '22222', '10000', 'M', '2014' )^
insert into hw3.schedule values ( '22222', '10001', 'M', '2014' )^
insert into hw3.schedule values ( '22222', '10002', 'F', '2014' )^
insert into hw3.schedule values ( '22222', '20001', 'F', '2014' )^
insert into hw3.schedule values ( '22222', '20000', 'F', '2014' )^
insert into hw3.schedule values ( '22222', '20001', 'F', '2014' )^
