To run you would need to load the p3.sqc file into db2
to do that first goto your command line and cd to where you have the file
then run docker cp p3.sqc 80e1499be02c:/database/config/db2inst1/p3.sqc or your equivalent
and then docker cp db-1.properties 80e1499be02c:/database/config/db2inst1/db-1.properties or your equivalent
and then docker cp p3_create.clp 80e1499be02c:/database/config/db2inst1/p3_create.clp or your equivalent

next you would need to connect to your db2 cs157a database
then you would need to run the p3_create.clp to create the new tables, I used db2 -tvf p3_create.clp but use your equivalent
then you need to run these commands in this order:
db2 connect to cs157a

db2 prep p3.sqc

gcc -I./sqllib/include -c p3.c

gcc -o p3 p3.o -L./sqllib/lib  -ldb2    

./p3 db-1.properties

note that these instructions worked for my windows 10 and my specs only. your steps might differ.

