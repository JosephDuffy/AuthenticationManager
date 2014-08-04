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

    public class var storedPIN: String? {
        return JNKeychain.loadValueForKey(kAMPINKey) as? String
    }

    public class func resetStoredPIN() {
        JNKeychain.deleteValueForKey(kAMPINKey)
    }

    lazy var bundle: NSBundle = {
        return NSBundle(identifier: "net.yetii.AuthenticationManager")
    }()

    var storyboard: UIStoryboard {
    get {
        return UIStoryboard(name: "Storyboard", bundle: self.bundle)
    }
    }

    /// Create and return a subclass of AuthenticationViewController used to perform the initial setup of the provided authentication type
    public func getAuthenticationSetupViewControllerForType(authenticationType: AuthenticationType) -> AuthenticationViewController {
        var viewController: AuthenticationViewController
        switch authenticationType {
        case .PIN:
            viewController = PINSetupViewController()
        }
        return viewController
    }

    /// Create and return a subclass of AuthenticationViewController used to modify the stored value of the provided authentication type
    public func getAuthenticationUpdateViewControllerForType(authenticationType: AuthenticationType) -> AuthenticationViewController {
        var viewController: AuthenticationViewController
        switch authenticationType {
        case .PIN:
            viewController = PINUpdateViewController()
        }
        return viewController
    }

    /// Create and return a subclass of AuthenticationViewController used to authenticate a user with the provided authentication type
    public func getAuthenticationViewControllerForType(authenticationType: AuthenticationType) -> AuthenticationViewController {
        var viewController: AuthenticationViewController
        switch authenticationType {
        case .PIN:
            viewController = PINAuthenticationViewController()
        }
        return viewController
    }
}
