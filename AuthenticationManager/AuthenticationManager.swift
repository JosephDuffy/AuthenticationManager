//
//  AuthenticationManager.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

private let _sharedInstance = AuthenticationManager()

public class AuthenticationManager {
    public class var sharedInstance: AuthenticationManager {
        return _sharedInstance
    }

    public var userDefaults: NSUserDefaults!
    {
    didSet {
        // Ensure the default values are registered
        self.userDefaults.registerDefaults([
            kAMDefaultAuthenticationMethodKey: AuthenticationType.PIN.toRaw()
            ])
    }
    }

    lazy var bundle: NSBundle = {
        return NSBundle(identifier: "net.yetii.AuthenticationManager")
    }()

    var storyboard: UIStoryboard {
    get {
        return UIStoryboard(name: "Storyboard", bundle: self.bundle)
    }
    }

    private init() {
        // Use the standard user defaults, unless this is overwritten
        self.userDefaults = NSUserDefaults.standardUserDefaults()
    }

    /// Create and return a subclass of AuthenticationViewController used to perform the initial setup of the provided authentication type
    public func getAuthenticationSetupViewControllerForType(authenticationType: AuthenticationType) -> AuthenticationViewController {
        var viewController: AuthenticationViewController
        switch authenticationType {
        case .PIN:
            viewController = PINSetupViewController()
        }
        viewController.userDefaults = self.userDefaults
        return viewController
    }

    /// Create and return a subclass of AuthenticationViewController used to modify the stored value of the provided authentication type
    public func getAuthenticationUpdateViewControllerForType(authenticationType: AuthenticationType) -> AuthenticationViewController {
        var viewController: AuthenticationViewController
        switch authenticationType {
        case .PIN:
            viewController = PINUpdateViewController()
        }
        viewController.userDefaults = self.userDefaults
        return viewController
    }

    /// Create and return a subclass of AuthenticationViewController used to authenticate a user with the provided authentication type
    public func getAuthenticationViewControllerForType(authenticationType: AuthenticationType) -> AuthenticationViewController {
        var viewController: AuthenticationViewController
        switch authenticationType {
        case .PIN:
            viewController = PINAuthenticationViewController()
        }
        viewController.userDefaults = self.userDefaults
        return viewController
    }
}
