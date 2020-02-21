--p2
--declare error cond for sqlstate example below
--docker cp ./p2_Create.sql ce
--cd sqllib
--cd samples
--cd ../sqlpl
--grep procedure *
--vi whiles.sql
--hand in p2.sql with a bunch of stored procedures inside
--/sqllib/samples/sqlpl
--procedure called dept_median, find the median
--declare variables used
--input and output param can also be passed in directly
--db2 "-td"@" -f whiles.db2" //mean it created the procedure successfully
--db2 "call dept_median(20,?)"
--db2 "select * from staff" //to get the department number
--default - show in exponential format
--create an account, auto generate id, and id is output param, so have to set output to id to display it
--sqlcode 0, error msg = blank if successful, or set display msg successful
--if/else, while, catch error, available to use
--how to know logged in? -> program need to remember who's logged in? inside procedure itself, it doesn't manage connection, stored procedure doesnt
--commit when it exits, (make change to db), treat procedure as functions, we do not need to store last logged in and withdrawing from account
--login is to test the pass, will not test to withdraw from some other acc
--lees scenarios in this assignment
--each procedure works independent of each other except transfer, call a withdraw and deposit from the inside
--if we have wrong param, we can return garbage, or have a exit handler for not found(dept no doesnt exist), return this value in case of while.db2 it is 6666
--create should never fail, id auto generated, never duplicate, assuming passing in good paramter
--other operations like withdraw, insert, can input wrong values
--pwd = sqllib/samples/sqlpl
--should not allow negative balance, deposit or withdraw a negative amount
--procedure doesn't check input, it checks inside and then determine what to do, perhaps do a case when to display the message
--add interest multiply and add the base balance, round the float to an int, when you test, test a bigger number
--want float as input param for interest
--when error, procedure is input,output, output the errorcode, param and error, dont need to alertsqlcode
--pass in param in a call statement to decrypt and encrypt pin
--function can only be envoked in sql statement
--when we insert, instead of pin, put function and pass in that
--we can call a proc in a proc
--how to capture output? ->declare a variable and then pass the value to that
--closing, withdrawing, and depositing, check for number if exists, we can use ifs, case, etc
--check some data restraints before sending it to the database
--fill in errorcode and msg, can use if/else, loops
--pick a nondefined errornumber, 99999, but msg should be customized
--can change param name from sqlcode

drop procedure p2.test2@
drop procedure p2.test1@
--
--
CREATE PROCEDURE p2.test1 
(IN jobName CHAR(8), OUT jobCount INTEGER)
LANGUAGE SQL
  BEGIN
    DECLARE SQLSTATE CHAR(5);

    declare c1 cursor for
      SELECT count(jobName) 
        from employee 
      where job = jobName;
    
    open c1;
    fetch c1 into jobCount;
    close c1;

END @

CREATE PROCEDURE p2.test2 
(IN jobName CHAR(18), OUT jobCount INTEGER, OUT msg VARCHAR(30))
LANGUAGE SQL
  BEGIN
    DECLARE err integer;
    DECLARE v_count integer;
    DECLARE error_cond CONDITION FOR SQLSTATE '22001';
    DECLARE CONTINUE HANDLER FOR error_cond
      SET msg = 'Input string too long'; 

    SET v_count = -1;

    CALL p2.test1(jobName, v_count);
    set jobCount = v_count;

END @
 