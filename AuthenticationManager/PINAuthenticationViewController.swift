//
//  PINAuthenticationViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

/// A view controller used to manage the input of a PIN and check its validity
public class PINAuthenticationViewController: PINViewController {
    public var PIN: String?
    public var authenticationDelegate: PINAuthenticationDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        if self.PIN == nil {
            // PIN has not been explictly set, try to load it from the keychain
            self.PIN = PINManager.sharedInstance.PIN
        }
        assert(self.PIN != nil, "Cannot load the PIN authentication view controller when no PIN has been set")
        self.viewController.delegate = self
        self.viewController.textLabel.text = "Enter your passcode"
        self.title = "Enter Passcode"
    }

    public func PINWasInput(inputPIN: String) {
        if self.PIN == nil {
            // PIN is not set, alert the delegate that a PIN has been input
            self.authenticationDelegate?.PINWasInput?(inputPIN)
        } else {
            // PIN has been set, check it
            if inputPIN == self.PIN {
                // Input PIN is correct
                self.authenticationDelegate?.authenticationDidSucceed()
            } else {
                // Input PIN is incorrect, update the UI...
                self.viewController.inputPINWasInvalid()
                // ... and alert the delegate
                self.authenticationDelegate?.inputPINWasIncorrect?(inputPIN)
            }
        }
    }
}
