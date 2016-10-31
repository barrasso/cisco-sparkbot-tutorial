## Create a Bot using Flint in NodeJS

**Note: If you are using the virtual machine on the USB we provided, (and have not set it up yet), make sure you follow the step by step tutorial how to setup your VM.  This tutorial is located in the root folder of the 'Get_Started` directory.**

### Installation

To begin setting up the environment:

0. Right click the desktop, and `open the Terminal`.

1. Make sure `git` is installed by running `which git`.
  - If things are set up correctly, the output should look like: `/usr/bin/git`
  - If not, install git by running `sudo yum install git-all`
 
2. Make sure `npm` is installed by running `which npm`.
  - Again, your output should look something like this: `/usr/local/bin/npm`

#### Once your bot development environment is setup, we can start coding!

### Getting Started

0. Create a new directory on your Desktop: `mkdir MyBotProject` *(name it whatever you like)*

1. Navigate to your newly created directory: `cd MyBotProject/`

1. Clone the Cisco Spark SDK for NodeJS ([Flint](https://github.com/nmarus/flint) by @nmarus)
  ```
  git clone https://github.com/nmarus/flint  
  ```
2. Install the project dependencies using npm: `npm install ./flint`

3. Create two files `mybot.js` and `package.json`:
  ```
  touch mybot.js
  touch package.json
  ```
4. Using your favorite editor, copy the following sample code into the respective files:

**package.json**
```javascript
{
  "name": "workspace",
  "version": "1.0.0",
  "description": "",
  "main": "mybot.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.15.2",
    "express": "^4.14.0",
    "node-flint": "^4.0.1"
  }
}
```
**mybot.js**
```javascript
var Flint = require('node-flint');
var webhook = require('node-flint/webhook');
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(bodyParser.json());

// flint options
var config = {
  webhookUrl: 'https://<host>/flint',
  token: '<token>',
  port: 8080,
  removeWebhooksOnStart: false,
  maxConcurrent: 5,
  minTime: 50
};

// init flint
var flint = new Flint(config);
flint.start();

// say hello
flint.hears('/hello', function(bot, trigger) {
  bot.say('Hello %s!', trigger.personDisplayName);
});

// add flint event listeners
flint.on('message', function(bot, trigger, id) {
  flint.debug('"%s" said "%s" in room "%s"', trigger.personEmail, trigger.text, trigger.roomTitle);
});

flint.on('initialized', function() {
  flint.debug('initialized %s rooms', flint.bots.length);
});

// define express path for incoming webhooks
app.post('/flint', webhook(flint));

// start express server
var server = app.listen(config.port, function () {
  flint.debug('Flint listening on port %s', config.port);
});

// gracefully shutdown (ctrl-c)
process.on('SIGINT', function() {
  flint.debug('stoppping...');
  server.close();
  flint.stop().then(function() {
    process.exit();
  });
});
```
