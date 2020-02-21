connect to cs157a^

create table hw3.student(id varchar(5) not null, first varchar(10) not null, last varchar(20) not null, primary key(id))^
create table hw3.class(classid varchar(5) not null, name varchar(30), desc varchar(30), primary key(classid))^
create table hw3.classreq(classid varchar(5), prereqid varchar(5), coreq char(1), foreign key(classid) references hw3.class(classid) on delete cascade)^
create table hw3.schedule(studentid varchar(5) not null, classid varchar(5) not null, semester char(1), year int, foreign key(studentid) references hw3.student(id), foreign key(classid) references hw3.class(classid) on delete cascade)^

create trigger check_requisites before insert on hw3.schedule referencing new as n for each row mode db2sql begin atomic If exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'T') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'T')) then signal sqlstate '88888' ('Missing Co-req'); End if; end if; end if; iF exists (select prereqid from hw3.classreq where classid = n.classid) then if exists (select classid from hw3.classreq where classid = n.classid and coreq = 'F') then if not exists (select classid from hw3.schedule where classid=ANY(select prereqid from hw3.classreq where classid = n.classid and coreq = 'F')) then signal sqlstate '88888' ('Missing Pre-req'); end if; end if; end if; End^

