//
//  PINAuthenticationViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

/// A view controller used to manage the input of a PIN and check its validity
public class PINAuthenticationViewController: PINViewController, PINViewControllerDelegate {
    public var PIN: String?
    public var authenticationDelegate: PINAuthenticationDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.viewController.delegate = self
        self.viewController.textLabel.text = "Enter your passcode"
        self.title = "Enter Passcode"
    }

    public func PINWasInput(PIN: String) {
        if !self.PIN {
            // PIN is not set, alert the delegate that a PIN has been input
            self.authenticationDelegate?.PINWasInput?(PIN)
        } else {
            // PIN has been set, check it
            if PIN == self.PIN {
                // Input PIN is correct
                self.authenticationDelegate?.authenticationDidSucceed?()
            } else {
                // Input PIN is incorrect, update the UI...
                self.viewController.inputPINWasInvalid()
                // ... and alert the delegate
                self.authenticationDelegate?.inputPINWasIncorrect?(PIN)
            }
        }
    }
}
