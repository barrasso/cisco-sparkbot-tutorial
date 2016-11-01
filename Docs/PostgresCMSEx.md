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
  
  
  
