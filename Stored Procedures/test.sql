connect to cs157a@

create or replace procedure p2.cust_crt 
(in name varchar(15), in gender char, in age integer, in pin integer, out id integer, out sql_code integer, out err_msg varchar(256))
language sql
    BEGIN
        declare exit handler for not found, sqlexception
            set sql_code = 88888;
            set err_msg = 'Customer not created';

        if gender <> 'M' THEN
            if gender <> 'F' THEN
                set sql_code = 88888;
                set err_msg = 'Gender must be M or F';
                return;
            end if;
        end if;

        if age < 0 THEN
            set sql_code = 88888;
            set err_msg = 'Age must be be a non negative integer';
            return;
        end if;

        if pin < 0 THEN
            set sql_code = 88888;
            set err_msg = 'Pin must be a non negative interger';
            return;
        end if;

        INSERT INTO P2.CUSTOMER (NAME, GENDER, AGE, PIN) VALUES (name, gender, age, p2.encrypt(pin));
        select max(id) into id from p2.customer;
        set sql_code = 0;
        set err_msg = 'Customer created successfully';
End@

create or replace procedure p2.CUST_LOGIN 
(in login_id integer, in login_pin integer, out Valid integer, out sql_code integer, out err_msg varchar(256))
language sql
    begin
        declare exit handler for not found, sqlexception
            set sql_code = 88888;
            set valid = '0';
            set err_msg = 'Login failed';
        
        if login_id < 100 THEN
            set sql_code = 88888;
            set valid = '0';
            set err_msg = 'invalid id';
            return;
        end if;

        select 'Welcome ' concat name into err_msg from p2.customer where (id = login_id and p2.decrypt(pin) = login_pin);
        set valid = '1';
end@

create or replace procedure p2.ACCT_OPN 
(in user_ID integer, in user_Balance integer, in user_Type char, out user_Number integer, out sql_code integer, out err_msg varchar(256))
language sql
    BEGIN
        declare exit handler for not found, sqlexception
            set sql_code = 88888;
            set err_msg = 'Invalid ID';
        
        if user_balance < 0 THEN
            set sql_code = 88888;
            set err_msg = 'Cannot open an account with a negative balance';
            return;
        end if;

        if user_type <> 'C' THEN
            if user_type <> 'S' THEN
                set sql_code = 88888;
                set err_msg = 'Account type can only be C or S';
                return;
            end if;
        end if;

        insert into p2.account (id, balance, type, status) values(user_id, user_balance, user_type, 'A');
        select max(number) into user_number from p2.account;
        set sql_code = 0;
        set err_msg = 'Account created successfully';
end@

create or replace procedure p2.ACCT_CLS 
(in user_Number integer, out sql_code integer, out err_msg varchar(256))
language sql
    BEGIN
        declare account_status char;
        declare exit handler for not found, sqlexception
            set sql_code = 88888;
            set err_msg = 'Invalid Account Number';

        select status into account_status from p2.account where number =  user_number;
        if account_status = 'I' THEN
            set sql_code = 88888;
            set err_msg = 'This account is already closed!';
            return;
        end if;

        update p2.account set balance = 0, status = 'I' where number = user_Number;
        set sql_code = 0;
        set err_msg = 'Account ' concat user_number concat ' has been successfully closed';
end@

create or replace procedure p2.ACCT_DEP 
(in user_number integer, in Amt integer, out sql_code integer, out err_msg varchar(256))
language sql
    begin
        declare account_status char;
        declare exit handler for not found, sqlexception
            set sql_code = 98888;
            set err_msg = 'Invalid Account Number';

        select status into account_status from p2.account where number = user_number;

        if account_status <> 'A' THEN
            set sql_code = 88888;
            set err_msg = 'The account is not active';
            return;
        end if;

        if amt < 0 THEN
            set sql_code = 88888;
            set err_msg = 'You must deposit a positve amount only';
            return;
        end if;

        update p2.account set balance = ((select balance from p2.account where number = user_number) + amt) where number = user_number and status = 'A';
        set sql_code = 0;
        set err_msg = 'Deposit was successful';
end@

create or replace procedure p2.ACCT_WTH 
(in user_Number integer, in Amt integer, out sql_code integer, out err_msg varchar(256))
language sql
    BEGIN
        declare account_balance integer;
        declare account_status char;
        declare exit handler for not found, sqlexception
            set sql_code = 88888;
            set err_msg = 'Invalid Account Number';

        select status into account_status from p2.account where number = user_number;

        if account_status <> 'A' THEN
            set sql_code = 88899;
            set err_msg = 'The account is not active';
            return;
        end if;

        select balance into account_balance from p2.account where number = user_number and status = 'A';

        if account_balance < amt then
            set sql_code = 88888;
            set err_msg = 'Insufficient Amount';
            return;
        end if;

        if amt < 0 THEN
            set sql_code = 88889;
            set err_msg = 'You must withdraw a positve amount only';
            return;
        end if;

        update p2.account set balance = ((select balance from p2.account where number = user_number) - amt) where number = user_number and status = 'A';
        set sql_code = 0;
        set err_msg = 'Withdrawal was successful';
end@

create or replace procedure p2.ACCT_TRX 
(in Src_Acct integer, in Dest_Acct integer, in Amt integer, out sql_code integer, out err_msg varchar(256))
language sql
    BEGIN   
        declare dest_acct_status char;
        declare exit handler for not found, sqlexception   
            set sql_code = 88888;
            set err_msg = 'Invalid Account Number';

        select status into dest_acct_status from p2.account where number = dest_acct;

        if dest_acct_status <> 'A' THEN
            set sql_code = 88888;
            set err_msg = 'You are trying to transfer to an inactive account!';
            return;
        end if;


        CALL p2.ACCT_WTH(src_acct, amt, sql_code, err_msg);
        if sql_code = 0 then
            CALL p2.ACCT_DEP(dest_acct, amt, sql_code, err_msg); --check for invalid acc
                if sql_code = 0 then
                    set sql_code = 0;
                    set err_msg = 'Transfer was successful';
                end if;
                if sql_code = 98888 THEN
                    set sql_code = 88888;
                    set err_msg = 'The account you are trying to transfer to does not exist';
                end if;
        end if;
        if sql_code = 88889 THEN
            set sql_code = 88888;
            set err_msg = 'Cannot transfer negative amount!';
        end if;
        if sql_code = 88899 THEN
            set sql_code = 88888;
            set err_msg = 'You are trying to transfer from an inactive account!';
        end if;
    
end@

create or replace procedure p2.ADD_INTEREST 
(in Savings_Rate float, in Checking_Rate float, out sql_code integer, out err_msg varchar(256))
language sql
    BEGIN
        declare exit handler for not found, sqlexception
            set sql_code = 88888;
            set err_msg = 'error in applying interest rates';

        if savings_rate < 0 THEN
            set sql_code = 88888;
            set err_msg = 'cannot have a negative interest for savings accounts';
            return;
        end if;

        if checking_rate < 0 THEN
            set sql_code = 88888;
            set err_msg = 'cannot have a negative interest for checking accounts';
            return;
        end if;

        update p2.account set balance = balance * (1 + savings_rate) where (type = 'S' and status = 'A');
        update p2.account set balance = balance * (1 + checking_rate) where (type = 'C' and status = 'A');
        set sql_code = 0;
        set err_msg = 'Interest rates successfully applied';
end@






        