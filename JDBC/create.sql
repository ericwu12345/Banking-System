-- Student ID: 011983517
-- Wu, Eric,
connect to cs157a
CREATE TABLE P1.CUSTOMER(ID INT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 100, INCREMENT BY 1, NO CACHE) primary key, name varchar(15) not null, gender char check(gender = 'M' or gender = 'F') not null, age integer check(age >= 0) not null, pin integer check(pin >= 0) not null)
CREATE TABLE P1.ACCOUNT(NUMBER INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1000, INCREMENT BY 1, NO CACHE) primary key, id int not null, balance integer check(balance >= 0) not null, type char check(type = 'C' or type = 'S') not null, status char check(status = 'A' or status = 'I') not null, foreign key(id) references p1.customer(id))
create view reportView as select p1.customer.id, p1.customer.name, p1.customer.gender, p1.customer.age, p1.account.number, p1.account.balance, p1.account.type, p1.account.status from p1.customer full outer join p1.account on p1.customer.id = p1.account.id where p1.account.status = 'A'