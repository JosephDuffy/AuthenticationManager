AuthenticationManager
===
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](http://opensource.org/licenses/MIT)

Authentication Manager is an iOS framework, written in Swift, aimed to aid in-app authentication.

Authentication Manager currently supports a single authentication type: PIN. PIN is exactly what it says on the tin: a Personal Identification Number, which in this instance is a 4 digit long numerical code.

##Implementation

The implementation of Authentication Manager is relatively simple. If you wish to see any example of the framework implemented in an iOS app, visit the (Authentication Manager Examples)[] After adding the AuthenticationManager framework in your project, the first step is get the shared instance of the `AuthenticationManager` by getting the `sharedInstance` class property of the `AuthenticationManager` class:

`let manager = AuthenticationManager.sharedInstance`

By default, Authentication Manager uses standard user defaults to store the value of the PIN that the user inputs. The instance of `NSUserDefaults` can be set on the `AuthenticationManager` instance via the `userDefaults` property. By default, during the setup setup, the user's input PIN is stored in the instance of an `NSUserDefaults` object in a key, as defined in the `kAMPINKey` constant. The `kAMPINKey` should **always** be used when retrieving the PIN the user has chosen.

### Setting the PIN

The `PINSetupViewController` presents the user with a view that guides the user through setting their PIN. It saves the PIN to the instance of `NSUserDefaults` set on the `AuthenticationManager` object when the setup has compete, and calls the `setupCompleteWithPIN(inputPIN: String)` method on the `setupDelegate`. Below is some example code to load and use this class.

```
let viewController = self.manager.getAuthenticationSetupViewControllerForType(.PIN) as PINSetupViewController
viewController.delegate = self
viewController.setupDelegate = self
self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
```

Because `PINSetupViewController` extends the `AuthenticationViewController`, the `viewInNavigationController` method can be used, which returns an instance of a `UINavigationController`, which displays the correct titles for the view and provides a cancel button for the user to cancel the process. In most cases, it is highly recommended you use this.

You should also implement the `setupCompleteWithPIN(PIN: String)`, which will be called once the setup has complete. In this method you dismiss the PIN view controller and perform any further tasks you wish to perform, for example:

```
func setupCompleteWithPIN(PIN: String) {
    self.dismissViewControllerAnimated(true, completion: nil)
    // Perform any further tasks
}
```

### Authenticating Using The PIN

Once the user has set their PIN you will want to be able to re-authenticate the user by asking them to input their PIN again. This can be done just as simply as setting the PIN:

```
let viewController = self.manager.getAuthenticationViewControllerForType(.PIN) as PINAuthenticationViewController
viewController.delegate = self
viewController.authenticationDelegate = self
self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
```

The object calling this code must comply to the `PINAuthenticationDelegate` protocol. The `PINAuthenticationDelegate` has various methods that can be implemented, but the only required method is the `authenticationDidSucceed` method. As with the `setupCompleteWithPIN(PIN: String)` method, you should dismiss the view controller in this method, for example:

```
func authenticationDidSucceed() {
    self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    // Perform any further tasks
}
```

### Updating The PIN

If you wish to provide the user the ability to update their PIN, you can do so in a similar manner to the way you setup and authenticate the PIN, for example:

```
let viewController = self.manager.getAuthenticationUpdateViewControllerForType(.PIN) as PINUpdateViewController
viewController.delegate = self
viewController.updateDelegate = self
self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
```

Similarly, the calling object should conform to the `PINUpdateDelegate` protocol and implement the `PINWasUpdated(newPIN: String)` method:

```
func PINWasUpdated(newPIN: String) {
    self.dismissViewControllerAnimated(true, completion: nil)
    // Perform any further tasks
}
```

### Resetting the PIN

Resetting the PIN is a simple task: remove the value of the PIN in the user defaults. This can be done by calling `AuthenticationManager.sharedInstance.userDefaults.removeObjectForKey(kAMPINKey)`