# Cisco Spark Developer Guide
Everything you need to start creating apps and bots using Cisco Spark. 

<img src="https://boulder.startupweek.co/wp-content/uploads/sites/23/2016/05/Spark-Logo-bsw.png" alt="Cisco Spark" width=" 333px"/>


## Contents 

- [Prerequisites](#prerequisites)
- [Overview](#overview)
- [Creating a Spark Bot](#creating-a-spark-bot)
  - [Using Gupshup's IDE to Code Your Bot](#using-gupshups-ide-to-code-your-bot)
- [Creating a Spark App](#creating-a-spark-app-integration)
  - [Getting Started with iOS](#getting-started-with-ios)
  - [Authorizing Your App Integration](#authorizing-your-app-integration)
  - [Handling Access Tokens](#handling-access-tokens)
  - [Invoking the APIs](#invoking-the-apis)
  - [Using Webhooks](#using-webhooks)
- [License](#license)


## Prerequisites

1. [Create a Cisco Spark account](https://web.ciscospark.com/#/signin)

2. [Log in to your Gupshup account](https://www.gupshup.io/developer/home#) using your Github or Facebook account.

## Overview

In Spark, conversations take place in virtual meeting rooms. Spark allows conversations to flow seamlessly between messages, video calls and real-time whiteboarding sessions. No other solution brings together so many facets of collaboration into a single unified platform.  [You can download the Cisco Spark client app here](https://www.ciscospark.com/downloads.html) for any device.

![Cisco Spark API](https://i.imgur.com/HE7jb4K.png)

Alternatively, visit the [Quick Reference](https://developer.ciscospark.com/quick-reference.html) page to learn more about what is possible using Spark APIs.


#### But wait, there's more!
Spark also provides the ability to create [bots](https://en.wikipedia.org/wiki/Internet_bot) that can automate routine tasks and inject contextual content into meetings and group conversations.


<img src="https://i.imgur.com/NgwaScg.png" alt="Spark Bots" height="333px"/>


You can learn more about what bots can do [here](https://developer.ciscospark.com/bots.html).


## Creating a Spark Bot

#####Once you have created a Spark account:

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Click on the plus sign in the upper right corner
- Select `Create a Bot`
- Enter in the basic information: e.g. the bot's display name, Spark username, and icon url
  - *You may choose to use this link: "http://i.imgur.com/KwdBVgD.png" for the icon url* 
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

Fill out the basic bot information (it does not have to share the same name as your Spark bot):

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

#### More Help & Examples

Here is another tutorial with more code examples from Gupshup on how to [build & deploy your bot on Cisco Spark](https://www.gupshup.io/developer/docs/bot-platform/guide/build-deploy-bot-on-cisco-spark).

Alternatively, you can also create your own custom bot using the comprehensive [Cisco Spark Bot SDK for NodeJS](https://github.com/nmarus/flint) called Flint created by [@nmarus](https://github.com/nmarus).

Check out the sample application using Flint [here](https://github.com/barrasso/cisco-spark-dev-guide/blob/master/Docs/FlintBotNodeJS.md).

## Creating a Spark App Integration

This process is very similar to creating a bot with Cisco Spark. Integrations are a way for your apps to request permission to invoke the Spark APIs on behalf of other Spark users. The process used to request permission is called an OAuth Grant Flow, and is documented in the [Spark Integrations guide](https://developer.ciscospark.com/authentication.html).

#####Once you have created an account on [developer.ciscospark.com](https://developer.ciscospark.com):

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Click on the plus sign in the upper right corner
- Select `Create an Integration`
- Enter in the basic app information: e.g. the app's name, description, and icon url
  - *You may choose to use this link: "http://i.imgur.com/KwdBVgD.png" for the icon url* 
- Enter a `Redirect URI` (This is used for [OAuth2](https://oauth.net/2/) authentication)
- Next, select your required persmissions from the list of available `Scope` options
- Once ready, select `Add Integration`

### Getting Started with iOS

One way to integrate the `SparkSDK` in your project is with [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation). 

First, make sure that you have CocoaPods installed on your machine.  

In Terminal, run the following commands:

```
gem install cocoapods
```

Next, setup CocoaPods:

```
pod setup
```

Once CocoaPods is setup, navigate to your Xcode project directory and add a `Podfile`:

```
pod init
```

Edit the `Podfile` to include `SparkSDK`.

**Your `Podfile` should look something like this:**

```
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

target 'YourApp' do
  pod 'SparkSDK'
end

```

Finally, install the `SparkSDK` from your project directory:

```
pod install
```

#### Authorizing Your App Integration

- Navigate to [My Apps](https://developer.ciscospark.com/apps.html) on the Spark developer portal
- Select (or create) the specific `Integration`
- Scroll down to the 'OAuth Settings`
- You will see your Integration's `Client ID`, `Client Secret`, and `OAuth Authorization URL`

You will need all of this information to authorize your application using the `SparkSDK`:

```swift

let clientId = "YOUR_CLIENT_ID"
let clientSecret = "YOUR_CLIENT_SECRET"
let scope = "spark:people_read spark:rooms_read spark:rooms_write spark:memberships_read spark:memberships_write spark:messages_read spark:messages_write"
let redirectUri = "SparkSDKDemo://response"

Spark.initWith(clientId: clientId, clientSecret: clientSecret, scope: scope, redirectUri: redirectUri, controller: self)
        
```

*Conversely, You can use the `OAuth Authorization URL` to initiate an OAuth permission request for this app. It is configured with your redirect URI and app scopes. Be sure to update the state parameter.*

Here is an example using `SFSafariViewController` to embed the authorization process within your app in Swift:

```swift

// MARK: Sign In With Spark - IBAction
    
@IBAction func signupButtonTouchUpInside(sender: AnyObject) 
{
  /* Open Webview from Spark OAuth URL */
  safariVC = SFSafariViewController(URL: NSURL(string: "https://api.ciscospark.com/v1/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=https%3A%2F%2Fexample.com%2Fapi%2Fauth%2Fspark%2Fcallback&scope=spark%3Amessages_write%20spark%3Arooms_read%20spark%3Amemberships_read%20spark%3Amessages_read%20spark%3Arooms_write%20spark%3Apeople_read%20spark%3Amemberships_write&state=YOUR_STATE_VAR")!)
  safariVC!.delegate = self
  self.presentViewController(safariVC!, animated: true, completion: nil)
}
    
```
#### Handling Access Tokens

Once your app integration is authorized, you will receive an `Access Token` to use for invoking calls to the Spark API.

You can authorize your application when it starts up by placing the following code in the `AppDelegate`'s `application:didFinishLaunchingWithOptions:` function:

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
{ 
  let sparkAccessToken = "YOUR_ACCESS_TOKEN" 
  Spark.initWith(accessToken: sparkAccessToken) 
  
  return true 
}

```

*More on [using access tokens to validate API calls](https://developer.ciscospark.com/authentication.html).*

#### Invoking the APIs

Now you can use the Spark API to:

- Create a room and invite people
- Search for people in your company
- Post messages into a room
- Get room history or be notified in real-time when new messages are posted by others

See the full list of available services using the Spark API [here](https://developer.ciscospark.com/quick-reference.html).

Here are some more code examples using the SparkSDK in Swift:

```swift
// IM example
do {
    // Create a new room
    let room = try Spark.rooms.create(title: "Hello World")
    print("\(room.title!), created \(room.created!): \(room.id!)")

    // Add a coworker to the room
    try Spark.memberships.create(roomId: room.id!, personEmail: "coworker@acm.com")

    // List the members of the room
    let memberships = try Spark.memberships.list(roomId: room.id!)
    for membership in memberships {
        print("\(membership.personEmail!)")
    }

    // Post a text message to the room
    try Spark.messages.postToRoom(roomId: room.id!, text: "Hello World")

    // Share a file with the room
    try Spark.messages.postToRoom(roomId: room.id!, files: "http://example.com/hello_world.jpg")

} catch let error as NSError {
    print("Error: \(error.localizedFailureReason)")
}

// Calling example
// Make a call
var outgoingCall =  Spark.phone.dial("coworker@acm.com", option: MediaOption.AudioVideo(local: ..., remote: ...)) { success in
    if !success {
        print("Failed to dial”)
    }
}

// Receive a call
class IncomingCallViewController: UIViewController, PhoneObserver {
    override func viewWillAppear(...) {
        ...
        PhoneNotificationCenter.sharedInstance.addObserver(self)
    }
    override func viewWillDisappear(...) {
        ...
        PhoneNotificationCenter.sharedInstance.removeObserver(self)
    }
    func callIncoming(call: Call) {
        // Show incoming call toast view
    }
    ...
}

```

Also, be sure to check out the alternative [Spark iOS SDK examples](https://github.com/ciscospark/spark-ios-sdk-example)!

#### Using Webhooks

Webhooks allow your app to be notified via HTTP when a specific event occurs on Spark. For example, your app can register a webhook to be notified when a new message is posted into a specific room.

Events trigger in near real-time allowing, your app and backend IT systems to stay in sync with new content and room activity.

**Here are some of the available webhook resources and events:**

Resource | Event | Trigger | Filters (optional)
-------- | ----- | ------- | ------------------
memberships	| created | Someone joined a room that you are in | roomId, personId, personEmail, isModerator
memberships	| updated	| Someone's membership was updated; primarily used to detect moderator changes | roomId, personId, personEmail, isModerator
memberships |	deleted |	Someone left or was kicked out of a room that you are in | roomId, personId, personEmail, isModerator
messages | created |	New message posted into a room | roomId, roomType, personId, personEmail, mentionedPeople, hasFiles
messages | deleted | A message was deleted | roomId, roomType, personId, personEmail, mentionedPeople, hasFiles
rooms | created | A new room was created by you or one of your integrations	| type, isLocked
rooms	| updated	| A room that you are in was updated; primarily used to detect when a room becomes Locked or Unlocked	| type, isLocked

For more on webhooks, visit [Webhooks Explained](https://developer.ciscospark.com/webhooks-explained.html) on the Cisco Spark Developer portal.

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

