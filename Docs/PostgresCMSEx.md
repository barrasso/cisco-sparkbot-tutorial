## Using Postgres in NodeJS

This example demonstrates how to query your local Postgres database to retrieve sample CMS healthcare data

**Note: If you are using the virtual machine on the USB we provided, (and have not set it up yet), make sure you follow the step by step tutorial how to setup your VM.  This tutorial is located in the root folder of the 'Get_Started` directory.**

### Get Started

Let's begin by accessing the database via command line:

0. Right click the desktop, and `open the Terminal`.

1. Change your user account to gain access to the db:
```
sudo -u postgres -i
```
  - The default password for `ahacker` is `password`

Once authenticated, run the `psql` command to access postgres via Terminal.

From there, you can run `\dt` to view all of the tables in the current database.

![psql](http://i.imgur.com/YDxpEfy.png)

To exit psql, type `CTRL + D`.

### Postgres Query Sample Code

0. 
2. Install the project dependencies using npm: `npm install ./flint`

3. Create two files `mybot.js` and `package.json`:
  ```
  touch mybot.js
  touch package.json
  ```
  
  ```javascript
  
  var pg = require('pg');

// instantiate a new client
const connectionString = 'postgres://postgres:archhacks2016@localhost:5432/postgres';
var client = new pg.Client(connectionString);

// connect to our database
client.connect(function (err) {
  if (err) throw err;

  // execute a query on our database
  client.query('SELECT * from prescription_drug_events limit 5;', function (err, resul$
    if (err) throw err;

    // just print the result to the console
    console.log(result.rows[0]);

    // disconnect the client
    client.end(function (err) {
      if (err) throw err;
    });
  });
```

``` javascript
{
  "name": "pgsql-workspace",
  "version": "1.0.1",
  "description": "",
  "main": "pgtest.js",
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

  
  
