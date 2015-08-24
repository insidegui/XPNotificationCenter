# XPNotificationCenter (Cross-process notification center)

A distributed notification center designed specifically for sending commands between iOS and WatchKit apps.

## Demo

See the demo app for a sample implementation. The app uses an app group to share user defaults between the iOS and WatchKit app, and XPNotificationCenter is used to send commands to the WatchKit app when the data is changed.

IMPORTANT: The demo app will not work unless you configure an AppID and an app group, after you have app groups enabled you need to change the defaults suite name in `Shared/SharedConstants.swift`

![screenshot](https://raw.githubusercontent.com/insidegui/XPNotificationCenter/master/screenshots/demo.gif)

## Usage

### Posting a notification

To send a notification, call `postNotificationName` with the name of the notification and the sender.

The name of the notification must be unique to the system, so I recommend appending your bundle ID to It.

    // send a notification to the watch extension so it knows the item list has changed
    XPNotificationCenter.defaultCenter.postNotificationName(NotificationNames.itemListAdded, sender: self)

### Receiving notifications

To receive notifications you need to register a receiver block in your WatchKit extension.

    XPNotificationCenter.defaultCenter.addObserver(self, name: NotificationNames.itemListAdded) { note in
        println("WatchKit extension received notification: \(note)")
    }

### Limitations

The biggest limitation of this method of communication between app and extension is that you can't send any userInfo through the notification, It can only be used to pass simple commands. To share data you'll have to use NSUserDefaults, files or the network.

### Other uses

Even though this was made specifically for communication between iOS apps and WatchKit extensions, XPNotificationCenter can be used to communicate between your app and other types of extensions and will also work on OS X.