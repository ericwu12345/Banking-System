connect to sample;
select empno, lastname, firstnme from emp where hiredate > date '2000-01-01' and hiredate < date '2005-12-31' order by lastname, firstnme;
select empno, lastname, firstnme, job, deptno, deptname from emp full outer join dept on workdept = deptno where deptname = 'OPERATIONS' or deptname = 'PLANNING' order by deptname;
select empno, lastname, firstnme, (salary + bonus + comm) as compensation from emp order by compensation desc;
select empno, lastname, firstnme, (salary + bonus + comm) as compensation from emp order by compensation fetch first 10 rows only;
select job, count(*) total from emp left outer join dept on workdept = deptno group by job order by total desc;
select deptno, deptname, count(*) total from emp left outer join dept on workdept = deptno group by deptno, deptname order by total;
terminate;
