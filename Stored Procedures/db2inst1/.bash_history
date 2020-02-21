db2 connect to sample
db2 "connect to sample"
db2 connect to sample
ls
cd sqllib
ls
cd samples
ls
cd ..
ls
exit
db2 connect to cs157a
db2 "create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic If exists (select prereqid from hw3.classreq where classid = n.classid) then If ((select coreq from hw3.classreq where classid = n.classid) = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; If exists (select prereqid from hw3.classreq where classid = n.classid) then if ((select coreq from hw3.classreq where classid = n.classid) = 'F') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End"
db2 -td"^" -f hw3.clp
db2 "drop trigger check_requisites"
db2 "create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic If exists (select prereqid from hw3.classreq where classid = n.classid) then If exists ((select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists ((select classid from hw3.classreq where classid = n.classid and coreq = 'F') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End"
db2 "create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic If exists (select prereqid from hw3.classreq where classid = n.classid) then If exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists ((select classid from hw3.classreq where classid = n.classid and coreq = 'F') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End"
db2 "





create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic  If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select clasid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End "
db2 "create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic  If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select clasid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End"
db2 "create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic  If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End"
db2 -td"^" -f hw3.clp
vi hw3.clp
create table hw3.student(id varchar(5) not null, first varchar(10) not null, last varchar(20) not null, primary key(id))^
create table hw3.class(classid varchar(5) not null, name varchar(30), desc varchar(30), primary key(classid))^
create table hw3.classreq(classid varchar(5), prereqid varchar(5), coreq char(1), foreign key(classid) references hw3.class(classid) on delete cascade)^
create table hw3.schedule(studentid varchar(5) not null, classid varchar(5) not null, semester char(1), year int, foreign key(studentid) references hw3.student(id), foreign key(classid) references hw3.class(classid) on delete cascade)^
create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic  If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 "drop trigger check_requisites"
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 "drop trigger check_requisites"
db2 "create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic if exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'F') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); else if(((select semester from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) < n.semester)) or ((select semester from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) = n.semester)) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; end if; End"
db2 "
create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic if exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'F') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); else if(select semester from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F') < n.semester) or select semester from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F') = n.semester) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; end if; End"
db2 -td"^" -f hw3.clp
vi drop.clp
vi create.clp
vi createdb.clp
db2 -td"^" -f createdb.clp
db2 -td"^" -f drop.clp
db2 -td"^" -f createdb.clp
db2 -td"^" -f hw3.clp
vi apples.clp
db2 -td"^" -f apples.clp
db2 -td"^" -f hw3.clp
vi hw3.clp
db2 -td"^" -f drop.clp
db2 -td"^" -f createdb.clp
db2 -td"^" -f apples.clp
exit
db2 connect to cs157a
db2 "connect to cs157a"
db2
exit
db2 connect to cs157a
db2 "connect to cs157a"
db2 
db2 list tables
list tables for all
db2 list tables for all
db2 connect to cs157a
db2 list tables
Create table p1.customer(id integer check (id >= 100) not null primary key, name varchar(15) not null, gender char check (gender = 'M' or gender = 'F') not null, age integer (check age >= 0) not null, pin integer check (pin >= 0) not null)
db2 "Create table p1.customer(id integer check (id >= 100) not null primary key, name varchar(15) not null, gender char check (gender = 'M' or gender = 'F') not null, age integer (check age >= 0) not null, pin integer check (pin >= 0) not null)"
db2 "CREATE TABLE P1.CUSTOMER(ID INT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 100, INCREMENT BY 1, NO CACHE))"
db2 drop table p1.customer
db2 "
CREATE TABLE P1.CUSTOMER(ID INT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 100, INCREMENT BY 1, NO CACHE), name varchar(15) not null, gender char check(gender = 'M' or gender = 'F') not null, age integer check(age >= 0) not null, pin integer check(pin >= 0) not null)"
db2 "drop table p1.customer"
db2 "CREATE TABLE P1.ACCOUNT(NUMBER INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1000, INCREMENT BY 1, NO CACHE) primary key, foreign key(id) references p1.customer(id), balance integer check(balance >= 0) not null, type char check(type = 'C' or type = 'S') not null, status char check(status = 'A' or status = 'I') not null)"
db2 "CREATE TABLE P1.CUSTOMER(ID INT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 100, INCREMENT BY 1, NO CACHE) primary key, name varchar(15) not null, gender char check(gender = 'M' or gender = 'F') not null, age integer check(age >= 0) not null, pin integer check(pin >= 0) not null)"
db2 "CREATE TABLE P1.ACCOUNT(NUMBER INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1000, INCREMENT BY 1, NO CACHE) primary key, foreign key(id) references p1.customer(id), balance integer check(balance >= 0) not null, type char check(type = 'C' or type = 'S') not null, status char check(status = 'A' or status = 'I') not null)"
db2 "CREATE TABLE P1.ACCOUNT(NUMBER INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1000, INCREMENT BY 1, NO CACHE) primary key, id int not null, balance integer check(balance >= 0) not null, type char check(type = 'C' or type = 'S') not null, status char check(status = 'A' or status = 'I') not null, foreign key(id) references p1.customer(id))"
db2 "insert into p1.customer(name, gender, age, pin) values('John', 'M', 18, 1000)"
db2 "insert into p1.customer(name, gender, age, pin) values('John', 'FM', 18, 1000)"
db2 "insert into p1.customer(name, gender, age, pin) values('John', 'L', 18, 1000)"
db2 "describe table p1.customer"
db2 
exit
db2 connect to cs157a
db2 "connect to cs157a"
db2
db2 connect to cs157a
values current schema
db2 list tables for all
db2 list tables for schema cs157a
db2 values current schema
exit
db2 connect to cs157a
exit
