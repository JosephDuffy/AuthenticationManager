AuthenticationManager
===
[![Version](https://img.shields.io/cocoapods/v/AuthenticationManager.svg?style=flat)](http://cocoadocs.org/docsets/AuthenticationManager)
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](http://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/cocoapods/p/AuthenticationManager.svg?style=flat)](http://cocoadocs.org/docsets/AuthenticationManager)

Authentication Manager is an iOS framework, written in Swift, aimed to aid in-app authentication.

Authentication Manager currently supports a single authentication type: PIN. PIN is exactly what it says on the tin: a Personal Identification Number, which in this instance is a 4 digit long numerical code.

##Installation

AuthenticationManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

`pod "AuthenticationManager"`

###Implementation

Once you've included the framework, the implementation is relatively simple. If you wish to see an example of the framework implemented in an iOS app, visit the [Authentication Manager Examples GitHub Repo](https://github.com/YetiiNet/AuthenticationManagerExamples). After adding the AuthenticationManager framework in your project, the first step is get the shared instance of the `AuthenticationManager` by getting the `sharedInstance` class property of the `AuthenticationManager` class:

`let manager = AuthenticationManager.sharedInstance`

Authentication Manager uses the built-in iOS keychain to store the value of the PIN that the user inputs. Although the value can be set, retrieved and deleted manually using the keychain, it is a requirement that when performing alterations to value of the PIN the `PINManager` class is used and the `JNKeychain` class (or another class interacting directly with the keychain) is **not** used. This is due to the value caching that the `PINManager` uses to speed up the reading of the PIN value.

There are no restrictions on the length of the PIN, other than it cannot have a length of 0 (i.e. an empty string). It does, however, have to be made up of valid numerical characters. These valid numerical characters are taken from the built-in character set `NSCharacterSet.decimalDigitCharacterSet()`, which includes non-roman numerical characters, such as `٣`, which is the Arabic number for `3`. When using the supplied views and view controllers, the input PIN must be exactly 4 characters.

### Setting the PIN

The `PINSetupViewController` presents the user with a view that guides the user through setting their PIN. It saves the PIN to the shared instance of `PINManager` when the setup has compete, and calls the `setupCompleteWithPIN(inputPIN: String)` method on the `setupDelegate`. Below is some example code to load and use this class.

```swift
let viewController = self.manager.getAuthenticationSetupViewControllerForType(.PIN) as PINSetupViewController
viewController.delegate = self
viewController.setupDelegate = self
self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
```

Because `PINSetupViewController` extends the `AuthenticationViewController`, the `viewInNavigationController` method can be used, which returns an instance of a `UINavigationController`, which displays the correct titles for the view and provides a cancel button for the user to cancel the process. In most cases, it is highly recommended you use this.

You should also implement the `setupCompleteWithPIN(PIN: String)`, which will be called once the setup has complete. In this method you dismiss the PIN view controller and perform any further tasks you wish to perform, for example:

```swift
func setupCompleteWithPIN(PIN: String) {
    self.dismissViewControllerAnimated(true, completion: nil)
    // Perform any further tasks
}
```

You can also manually set the PIN using the shared instance of the `PINManager` class, e.g.:

`PINManager.sharedInstance.PIN = "1234"`

This is useful when migrating from an old implementation and keeping the user's PIN

### Authenticating Using The PIN

Once the user has set their PIN you will want to be able to re-authenticate the user by asking them to input their PIN again. This can be done just as simply as setting the PIN:

```swift
let viewController = self.manager.getAuthenticationViewControllerForType(.PIN) as PINAuthenticationViewController
viewController.delegate = self
viewController.authenticationDelegate = self
self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
```

The object calling this code must comply to the `PINAuthenticationDelegate` protocol. The `PINAuthenticationDelegate` has various methods that can be implemented, but the only required method is the `authenticationDidSucceed` method. As with the `setupCompleteWithPIN(PIN: String)` method, you should dismiss the view controller in this method, for example:

```swift
func authenticationDidSucceed() {
    self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    // Perform any further tasks
}
```

### Updating The PIN

If you wish to provide the user the ability to update their PIN, you can do so in a similar manner to the way you setup and authenticate the PIN, for example:

```swift
let viewController = self.manager.getAuthenticationUpdateViewControllerForType(.PIN) as PINUpdateViewController
viewController.delegate = self
viewController.updateDelegate = self
self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
```

Similarly, the calling object should conform to the `PINUpdateDelegate` protocol and implement the `PINWasUpdated(newPIN: String)` method:

```swift
func PINWasUpdated(newPIN: String) {
    self.dismissViewControllerAnimated(true, completion: nil)
    // Perform any further tasks
}
```

As with setting the PIN, you can do this manually:

`PINManager.sharedInstance.PIN = "6789"`

### Resetting the PIN

Resetting the PIN is a simple task: set the value of the PIN to `nil`. This can be done by calling `PINManager.sharedInstance.PIN = nil`

## Upcoming

There are various features that will hopefully be coming to Authentication Manager, some of which include:

* Support for more authentication methods, including biometrics
* Localisation of the user-facing aspects of the application

## Helping Authentication Manager

Although no one is required to (obviously), if you feel so inclined, you could help out in any of the following ways:

* Use the framework in your own application, or point other people the framework's way
* Let me know if you do use it
* Post any issues you find
* Create a pull request if you make any improvements or additions