# Cisco Spark Developer Guide
Everything you need to start creating apps and bots using Cisco Spark. 

<img src="https://boulder.startupweek.co/wp-content/uploads/sites/23/2016/05/Spark-Logo-bsw.png" alt="Cisco Spark" width=" 333px"/>


## Contents 

...

## Preresiquites

- First, [sign up] (https://web.ciscospark.com/#/signin) for a Cisco Spark developer account
- To start building bots, [create an account](https://www.gupshup.io/developer/home#) on Gupshup 

## Overview

In Spark, conversations take place in virtual meeting rooms. Spark allows conversations to flow seamlessly between messages, video calls and real-time whiteboarding sessions. No other solution brings together so many facets of collaboration into a single unified platform.  [You can download the Cisco Spark client app here](https://www.ciscospark.com/downloads.html) for any device.

Alternatively, view the [Quick Reference](https://developer.ciscospark.com/quick-reference.html) page to learn more about what is possible using Spark APIs.

<screen shot of reference guide/>


###### But wait, there's more!
Spark also provides the ability to create Spark Bots that can automate routine tasks and inject contextual content into meetings and group conversations.


<insert img/gif of sample bots/>


More on [What are Bots?](https://developer.ciscospark.com/bots.html)


## Creating a Spark Bot

Once you have created an account on [developer.ciscospark.com](developer.ciscospark.com):

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Click on the plus sign in the upper right corner
- Select `Create a Bot`
- Enter in the basic information: e.g. the bot's display name, Spark username, and icon url
- Once ready, select `Add Bot`

< add onboarding images />

REMEMBER TO COPY YOUR ACCESS KEY. you'll need it later.

**Note:**

`After creating a new bot, the bot's Access Token will only be displayed once.`
`Make sure to scroll down on the confirmation page, copy the token and keep it somewhere safe` 
`If you misplace it, you can always generate a new one by finding the bot in My Apps and selecting "Regenerate Access Token" from the edit page.`

Next, go to your [Gupshup Dashboard](https://www.gupshup.io/developer/dashboard) and click the plus sign in the upper right corner

< add gupshup onboarding screenshots>

< add gupshup js IDE screenshots>

<show communicating with spark bot after saving IDE code>
...

## Using Spark with Javascript (NodeJS)

[Cisco Spark Bot SDK for Node JS](https://github.com/nmarus/flint)

[Build & Deploy Bot on Cisco Spark](https://www.gupshup.io/developer/docs/bot-platform/guide/build-deploy-bot-on-cisco-spark)
...

###Examples
####Getting data
####Routing messages
####Posting data
####Webhooks

## Creating a Spark App 

...

## Using Spark with Swift (iOS) 

### Setup Project

### Add API Keys

### OAuth2 Authentication

### Handling Spark API Calls

...

##Other Use Case Examples
#### 1. Med Reminder Bot
#### 2. Using Python to Analyze Data
...

## Design Tools and Resources
...

## Links & References
...

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

