This folder contains sample java code for access CMS data in the postgres database.

1. Postgresql user setup:
The CMS tables are in the postgres schema. It's generally a good practice to use an app db user for the application instead of using the default 'postgres' user. 

Sudo to root user to perform those steps.

Edit pg_hba.conf under /var/lib/pgsql/data add:
# "local" is for Unix domain socket connections only
local   all             postgres                                trust
local   all             all                                     md5

Restart postgresql:
systemctl restart postgresql

Login to psql
psql -U postgres

Use following commands on the psql commandline:

postgres=# CREATE ROLE dbuser LOGIN PASSWORD '12345';
postgres=# \c postgres
postgres=# GRANT ALL ON DATABASE postgres to dbuser;
postgres=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dbuser;
postgres=# GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO dbuser;
postgres=# \q

2. Run sample java:
Copy the javadb folder from shared to the VM user home folder: /home/ahacker/
java -cp /home/ahacker/javadb/postgresql-9.4.1207.jre7.jar:/home/ahacker/javadb PostgresqlTest

It queries the first 5 rows in the procedure_codes table and print the result to stdout. You can explore data in other tables as well.

