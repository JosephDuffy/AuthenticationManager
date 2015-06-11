//
//  AuthenticationManager.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class AuthenticationManager {
    public class var sharedInstance: AuthenticationManager {
        struct Static {
            static let instance: AuthenticationManager = AuthenticationManager()
        }
        return Static.instance
    }

    lazy var bundle: NSBundle = {
        return NSBundle(identifier: "net.yetii.AuthenticationManager")!
    }()

    var storyboard: UIStoryboard {
    get {
        return UIStoryboard(name: "Storyboard", bundle: self.bundle)
    }
    }

    /// Create and return a subclass of AuthenticationViewController used to perform the initial setup of the provided authentication type
    public func getAuthenticationSetupViewControllerForType(authenticationType: AuthenticationType) -> AuthenticationViewController {
        switch authenticationType {
        case .PIN:
            return PINSetupViewController()
        }
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
