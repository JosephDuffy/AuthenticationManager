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
            kAMDefaultAuthenticationKey: AuthenticationType.PINCode.toRaw(),
            kAMDefaultPINCodeKey: "1234"
            ])
    }
    }

    private init() {
        // Use the standard user defaults, unless this is overwritten
        self.userDefaults = NSUserDefaults.standardUserDefaults()
    }

    public func createAuthenticationViewController() -> AuthenticationViewController {
        let defaultAuthenticationMethodInt = self.userDefaults.valueForKey(kAMDefaultAuthenticationKey) as Int
        let defaultAuthenticationMethod = AuthenticationType.fromRaw(defaultAuthenticationMethodInt)
        return self.createAuthenticationViewController(defaultAuthenticationMethod!)
    }

    public func createAuthenticationViewController(authenticationType: AuthenticationType) -> AuthenticationViewController {
        let mainBundlePath: String = NSBundle.mainBundle().resourcePath
        let frameworkBundlePath = mainBundlePath.stringByAppendingPathComponent("Frameworks/AuthenticationManager.framework")
        let frameworkBundle = NSBundle(path: frameworkBundlePath)
        let storyboard = UIStoryboard(name: "Storyboard", bundle: frameworkBundle)
        var viewController: AuthenticationViewController
        switch authenticationType {
        case .PINCode:
            viewController = storyboard.instantiateViewControllerWithIdentifier("PINAuthentication") as PINAuthentcationViewController
        case .Password:
            viewController = storyboard.instantiateViewControllerWithIdentifier("PasswordAuthentication") as PINAuthentcationViewController
        case .Biometrics:
            viewController = storyboard.instantiateViewControllerWithIdentifier("BiometricsAuthentication") as PINAuthentcationViewController
        }
        viewController.userDefaults = self.userDefaults
        return viewController
    }

    func loadAuthenticationSetupViewController(authenticationType: AuthenticationType) {
        // TODO: Create the views for these and implement this method
    }
}
