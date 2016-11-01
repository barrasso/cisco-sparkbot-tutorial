## Example Using Postgres in NodeJS

This guide shows how to query your local Postgres database to retrieve sample CMS healthcare data.

**Note: If you are using the virtual machine on the USB we provided, (and have not set it up yet), make sure you follow the step by step tutorial how to setup your VM.  This tutorial is located in the root folder of the 'Get_Started` directory.**

### Initial Setup

Let's begin by accessing the database via command line:

0. Right click the desktop, and `open the Terminal`.

1. Change your user account to gain access to the db:

```
sudo -u postgres -i
```
  - The default password for `ahacker` is `password`

Once authenticated, run the `psql` command to access postgres via Terminal.

From there, you can run `\dt` to view all of the tables in the current database.

*Type `\h` to see a list of all available commands.*


![psql](https://i.imgur.com/YDxpEfy.png =300px)


**NOTE:** In order to use the postgres database in your own NodeJS app, make sure you change the password.

You can change the postgres password by running the following command in `psql`:

```
ALTER USER "postgres" WITH PASSWORD 'archhacks2016'
```
*(change the password to whatever you like, just make sure to remember it!)*


To exit psql, type `CTRL + D`.

### Postgres Query Example

Instead of accessing the database tables via the command line, we can also query the same data using NodeJS. 

0. Start by creating two example files: `package.json` and `postgres-example.js`:

```
touch package.json
  
touch postgres-example.js
```

Here is some sample code to get started:

**package.json**
``` javascript
{
  "name": "pgsql-workspace",
  "version": "1.0.1",
  "description": "",
  "main": "postgres-example.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.15.2",
    "express": "^4.14.0",
    "node-flint": "^4.0.1",
    "pg": "^6.1.0"
  }
}
```  
  
**postgres-example.js**
```javascript
var pg = require('pg');

// instantiate a new client
const connectionString = 'postgres://postgres:archhacks2016@localhost:5432/postgres';
var client = new pg.Client(connectionString);

// connect to our database
client.connect(function (err) {
  if (err) throw err;

  // execute a query on our database
  client.query('SELECT * from prescription_drug_events limit 5;', function (err, result) {
    if (err) throw err;

    // just print the result to the console
    console.log(result.rows[0]);

    // disconnect the client
    client.end(function (err) {
      if (err) throw err;
    });
  });
```

1. Next, install the project dependencies:

```
npm install
```

2. Finally, execute the code example:

``` 
node postgres-example.js
```

Your output should look something like this:


![Postgres Example Output](http://i.imgur.com/d2BMS0P.png)


Make sure to change the string in `postgres-example.js` to perform your own custom queries:

```javascript
// execute a query on our database
client.query('SELECT * from prescription_drug_events limit 5;', function (err, result) {...}
```

### Query for Healthcare Data Using a Bot
  

### More Sample Queries

- basic query

- limit 10 query

- advanced query

```sql
SELECT clm_admsn_dt AS "Inpatient.Admission.Date", prvdr_num AS "Provider.Institution", at_physn_npi AS "Attending.Physician.NPI" FROM inpatient_claims WHERE desynpuf_id = '0007F12A492FD25D';
```
  
### License

