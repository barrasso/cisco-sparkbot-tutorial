# Cisco Spark Developer Guide
Everything you need to start creating apps and bots using Cisco Spark. 

<img src="https://boulder.startupweek.co/wp-content/uploads/sites/23/2016/05/Spark-Logo-bsw.png" alt="Cisco Spark" width=" 333px"/>


## Contents 

...

## Preresiquites

- First, [sign up](https://web.ciscospark.com/#/signin) for a Cisco Spark developer account
- Second, [create an account](https://www.gupshup.io/developer/home#) on Gupshup 

## Overview

In Spark, conversations take place in virtual meeting rooms. Spark allows conversations to flow seamlessly between messages, video calls and real-time whiteboarding sessions. No other solution brings together so many facets of collaboration into a single unified platform.  [You can download the Cisco Spark client app here](https://www.ciscospark.com/downloads.html) for any device.

<img src="https://s25.postimg.org/e0hyo16qn/spark_app_cloud_1.png" alt="Cisco Spark API"/>

Alternatively, visit the [Quick Reference](https://developer.ciscospark.com/quick-reference.html) page to learn more about what is possible using Spark APIs.

<screen shot of reference guide/>


#### But wait, there's more!
Spark also provides the ability to create [bots](https://en.wikipedia.org/wiki/Internet_bot) that can automate routine tasks and inject contextual content into meetings and group conversations.


<img src="https://s25.postimg.org/g6c9ija73/bots_new_platform.png" alt="Spark Bots" height="333px"/>


<insert img/gif of sample bots/>


Alternatively, you can learn more about what bots can do [here](https://developer.ciscospark.com/bots.html).


## Creating a Spark Bot

#####Once you have created an account on [developer.ciscospark.com](developer.ciscospark.com):

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Click on the plus sign in the upper right corner
- Select `Create a Bot`
- Enter in the basic information: e.g. the bot's display name, Spark username, and icon url
- Once ready, select `Add Bot`

<img src="https://s25.postimg.org/s0t77nn8f/Screen_Shot_2016_10_21_at_11_14_40_AM.png"/>

After creating your bot, scroll down the page and you will be able to see the bot's `Access Token`.

<img src="https://s25.postimg.org/ffo4qhx7j/Screen_Shot_2016_10_20_at_4_35_56_PM.png"/>

**Remember to copy the `Access Token` because you'll need it for later.**

`Note: After creating a new bot, the bot's Access Token will only be displayed once.`
`Make sure to scroll down on the confirmation page, copy the token and keep it somewhere safe` 
`If you misplace it, you can always generate a new one by finding the bot in My Apps and selecting "Regenerate Access Token" from the edit page.`

#####Next, go to your [Gupshup Dashboard](https://www.gupshup.io/developer/dashboard) and click the plus sign in the upper right corner:

<img src="https://s25.postimg.org/ivg901ufz/Screen_Shot_2016_10_20_at_4_26_17_PM.png"/>

Then, create a bot using the popup wizard in Gupshup:
<img src="https://s25.postimg.org/l7jnjwhnj/Screen_Shot_2016_10_20_at_4_20_20_PM.png"/>

Fill out the basic bot information:
<img src="https://s25.postimg.org/sc1gsxowv/Screen_Shot_2016_10_20_at_4_23_24_PM.png"/>

Make sure the `Code Your Own Bot` option is checked and select `Create Bot`:
<img src="https://s25.postimg.org/aoo98h4db/Screen_Shot_2016_10_20_at_4_25_55_PM.png"/>

Now, go back to your Gupshup dashboard and select the `Channels` link underneath the `Publish` column:

<img src="https://s25.postimg.org/w0vr65obj/Screen_Shot_2016_10_20_at_4_27_09_PM.png"/>

Scroll down to the `Cisco Spark` row and click the `Publish` button.
This will present a popup which prompts you to enter your `Access Token` copied from Spark:

<img src="https://s25.postimg.org/u057lbs67/Screen_Shot_2016_10_20_at_4_37_26_PM.png"/>

After submitting and publishing the `Access Token` to Gupshup, you have connected with your Cisco Spark Bot and can begin coding!

#### Using Gupshup's IDE to Code Your Bot

Go to your Gupshup Dashboard, and click on the `IDE` link underneath the `Develop` column.

This will bring up the Gupshup IDE:

<img src="https://s25.postimg.org/5aph0xen3/Screen_Shot_2016_10_20_at_4_38_23_PM.png"/>

<add quick explanation of how it works, nodeJS, and how to use IDE>

<add example code to show specific example works>

<show communicating with spark bot after saving IDE code>


...

Here is another tutorial with more code examples from Gupshup on how to [build & deploy your bot on Cisco Spark](https://www.gupshup.io/developer/docs/bot-platform/guide/build-deploy-bot-on-cisco-spark)

Alternatively, you can create your own custom bot using the comprehensive [Cisco Spark Bot SDK for NodeJS](https://github.com/nmarus/flint) created by [@nmarus](https://github.com/nmarus).

## Creating a Spark App (Integration)

This process is very similar to creating a bot with Cisco Spark. Integrations are a way for your apps to request permission to invoke the Spark APIs on behalf of other Spark users. The process used to request permission is called an OAuth Grant Flow, and is documented in the [Spark Integrations guide](https://developer.ciscospark.com/authentication.html).

#####Once you have created an account on [developer.ciscospark.com](developer.ciscospark.com):

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Click on the plus sign in the upper right corner
- Select `Create an Integration`
- Enter in the basic app information: e.g. the app's name, description, and icon url
- Enter a `Redirect URI` (This is used for [OAuth2](https://oauth.net/2/) authentication)
- Next, select your required persmissions from the list of available `Scope` options
- Once ready, select `Add Integration`


...

## Using Spark with Swift (iOS) 

### Setup Project

### Add API Keys

### OAuth2 Authentication

### Handling Spark API Calls

...

##Use Case Examples

#### 1. Med Reminder Bot

<brief description/>
<gif of med reminder bot prototype flow/>

#### 2. Doctor Telepresence App using Swift

<brief description>
<gif/video of telepresence app>

#### 3. GitHub Bot using Python

It listens for commits & comments on a particular repo and posts the details into a Spark room

[](https://github.com/ciscospark/Spark-API-Demos/blob/master/SparkGitHubBot/github-bot.py)

...

## Links & References

- [Cisco Spark GitHub](https://github.com/ciscospark)
-
-

## License

*2016 Cisco Systems, Inc. All rights reserved. Built for [ArchHacks](https://archhacks.io) 2016.*

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

