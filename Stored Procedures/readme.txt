I changed some of the parameter names for the stored procedure but function are the same.

To run, use @ as the delimiter.

First load p2.sql into the database
Something like --- docker cp p2.sql 80e1499be02c:/database/config/db2inst1/p2.sql --- but make sure to change it so it works for you

Then call p2_create.sql to create the tables
db2 -tvf p2_create.sql

Then call p2.sql to add the stored procedures
db2 -td"@" -f p2.sql

Then call p2test.sql to test the stored procedures
db2 -tvf p2test.sql