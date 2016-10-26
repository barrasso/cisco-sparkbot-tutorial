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

![Cisco Spark API](https://i.imgur.com/HE7jb4K.png)

Alternatively, visit the [Quick Reference](https://developer.ciscospark.com/quick-reference.html) page to learn more about what is possible using Spark APIs.

*screen shot of reference guide*


#### But wait, there's more!
Spark also provides the ability to create [bots](https://en.wikipedia.org/wiki/Internet_bot) that can automate routine tasks and inject contextual content into meetings and group conversations.


<img src="https://i.imgur.com/NgwaScg.png" alt="Spark Bots" height="333px"/>



Alternatively, you can learn more about what bots can do [here](https://developer.ciscospark.com/bots.html).


## Creating a Spark Bot

#####Once you have created an account on [developer.ciscospark.com](developer.ciscospark.com):

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Click on the plus sign in the upper right corner
- Select `Create a Bot`
- Enter in the basic information: e.g. the bot's display name, Spark username, and icon url
- Once ready, select `Add Bot`

<img src="https://imgur.com/bh0AVpQ.png"/>

After creating your bot, scroll down the page and you will be able to see the bot's `Access Token`.

<img src="https://imgur.com/JjSKo2b.png"/>

**Remember to copy the `Access Token` because you'll need it for later.**

`Note: After creating a new bot, the bot's Access Token will only be displayed once.`
`Make sure to scroll down on the confirmation page, copy the token and keep it somewhere safe.` 
`If you misplace it, you can always generate a new one by finding the bot in My Apps and selecting "Regenerate Access Token" from the edit page.`

#####Next, open up your [Gupshup Dashboard](https://www.gupshup.io/developer/dashboard), and click the plus sign in the upper right corner:

<img src="https://imgur.com/S8N0boh.png"/>

Then, create a bot using the popup wizard in Gupshup:

<img src="https://imgur.com/RBEboPx.png"/>

Fill out the basic bot information:

<img src="https://imgur.com/gvu0gaW.png"/>

Make sure the `Code Your Own Bot` option is checked and select `Create Bot`:

<img src="https://imgur.com/8jmotCe.png"/>

Now, go back to your Gupshup dashboard and select the `Channels` link underneath the `Publish` column:

<img src="https://imgur.com/Rw4nD2r.png"/>

Scroll down to the `Cisco Spark` row and click the `Publish` button.
This will present a popup which prompts you to enter your `Access Token` copied from Spark:

<img src="https://imgur.com/O155fZZ.png"/>

After submitting and publishing the `Access Token` to Gupshup, you have connected with your Cisco Spark Bot and can begin coding!

#### Using Gupshup's IDE to Code Your Bot

Go to your Gupshup Dashboard, and click on the `IDE` link underneath the `Develop` column.

This will bring up the Gupshup IDE:

<img src="https://imgur.com/YEmoCJh.png"/>

Now, you are all setup and ready to start coding your own bot!

When you are ready to test, click the `Deploy` button to publish your code and update your bot.

Here is another tutorial with more code examples from Gupshup on how to [build & deploy your bot on Cisco Spark](https://www.gupshup.io/developer/docs/bot-platform/guide/build-deploy-bot-on-cisco-spark).

Alternatively, you can also create your own custom bot using the comprehensive [Cisco Spark Bot SDK for NodeJS](https://github.com/nmarus/flint) created by [@nmarus](https://github.com/nmarus).

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

##Use Case Examples

#### 1. Virtual Medical Assistant Bot (NodeJS)

*include brief description*
*gif of med reminder bot prototype flow*

<img src="https://i.imgur.com/FC82Gc5.png" width="200px"/>
<img src="https://imgur.com/m8obtqx.png" width="200px"/>

#### 2. Doctor Telepresence Example App (Swift)

*include brief description*
*gif/video of telepresence app*

#### Setup Project

#### Add API Keys

#### OAuth2 Authentication

#### Handling Spark API Calls

...


#### 3. GitHub Commit Bot (Python)

It listens for commits & comments on a particular repo and posts the details into a Spark room

[](https://github.com/ciscospark/Spark-API-Demos/blob/master/SparkGitHubBot/github-bot.py)


#### 4. Data Analytics Timeline Bot (Python)

##### Natural Language Processing with Spacy

...


## Links & References

- [Cisco Spark Developer Portal](https://developer.ciscospark.com/)
- [Gupshup Developer Portal](https://www.gupshup.io/developer/home)
- [Cisco Spark GitHub](https://github.com/ciscospark)
- [Cisco Spark Support](https://developer.ciscospark.com/support.html)

#### Spark SDKs
- [Cisco Spark - iOS SDK](https://github.com/ciscospark/spark-ios-sdk)
- [Cisco Spark - Java SDK](https://github.com/ciscospark/spark-java-sdk)
- [Cisco Spark - Javascript SDK](https://github.com/ciscospark/spark-js-sdk)

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

