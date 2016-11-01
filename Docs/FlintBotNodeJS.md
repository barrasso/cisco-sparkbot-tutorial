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


### Running the Sample Bot


0. Make sure to install the additional project dependencies by running `npm install`

1. Now, let's run our test bot to make sure it works! 

Run the following command to confirm: 

```
node mybot.js
```

**Note: If you experience some error messages due to syntax errors, your Node version may be out of date.**

To update to the latest version of node, follow the instructions below:
  
  - Switch to `super user` privileges by running the `su` command and entering in the root pw. (found in VM instructions)
    
  - Once successfully authenticated, globally install `n` by running: `sudo npm install -g n`
    
  - Next, install the latest stable version of node: `sudo n stable`
    
  - Check your node version: `node -v`.
    
      ```
      v7.0.0
      
      ```
      
### Connecting to Spark

To begin listening for new messages, you must first create a [webhook](https://developer.ciscospark.com/webhooks-explained.html). 

First off, you'll need to create a bot on Spark:

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Click on the plus sign in the upper right corner
- Select `Create a Bot`
- Enter in the basic information: e.g. the bot's display name, Spark username, and icon url
  - *You may choose to use this link: `https://i.imgur.com/H0bCPEm.png` for the icon url* 
- Once ready, select `Add Bot`

<img src="https://imgur.com/bh0AVpQ.png"/>

- Next, open the Spark client app on your phone or desk
- Search for your newly created bot by username and add it to a room
- Once you created a new room, navigate to the [Spark developer portal](https://developer.ciscospark.com/endpoint-rooms-get.html) to get the `roomId`
```
GET
https://api.ciscospark.com/v1/rooms
```

- Using the [get rooms endpoint](https://developer.ciscospark.com/endpoint-rooms-get.html), make sure `Test Mode` is set to ON
- Scroll down the page and take note of the `Authorization` header (you will need that Bearer token)
- Click the `Run` button
- If successful, your response will be displayed on the right side of the screen
- Copy the `"id"` variable of the respective bot room

### Creating a Webhook

- Navigate to [this resource](https://developer.ciscospark.com/endpoint-webhooks-post.html) to create a webhook
  - Alternatively, you can perform a POST using Postman to create webhooks
```
POST
https://api.ciscospark.com/v1/webhooks
```
- Fill out the required variables: `name`, `targetUrl`, `resource`, `event`, `filter`, and `secret`. 
- In a production enviroment, you would setup the webhook so that Spark sends the request to your app.  However, you can use [http://requestb.in/](requestb.in) so that you can see how a webhook works without developing an app first.
  1. Go to [http://requestb.in/](http://requestb.in/)
  2. Click on `Create a Requestb.in`
  3. Take note of your new bin URL
  4. You can stay on this page and refresh it to see incoming POST data from the Spark webhook
  
  In `mybot.js` make sure to edit the `webhookUrl` and `token` variables to include your new ` callback URL` and `Bearer Token`:
  
```javascript
// flint options
var config = {
  webhookUrl: 'https://<host>/flint',
  token: '<token>',
  port: 8080,
  removeWebhooksOnStart: false,
  maxConcurrent: 5,
  minTime: 50
};
```
Once saved, now run your bot using `node mybot.js` and the webhook will begin to POST new messages in the Spark room.

##### Want to incorporate healthcare data into your bots?  [Check out our example](https://github.com/barrasso/cisco-spark-dev-guide/blob/master/Docs/PostgresCMSEx.md) using Postgres to query a CMS database.

### License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this program. If not, see http://www.gnu.org/licenses/.
