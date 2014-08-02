//
//  PINModifyViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 02/08/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class PINUpdateViewController: PINViewController {
    var newPIN: String?
    var viewIsAuthenticated = false
    public var updateDelegate: PINUpdateDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.viewController.delegate = self
        self.viewController.textLabel.text = "Enter your old passcode"
        self.title = "Change Passcode"
    }

    public func PINWasInput(inputPIN: String) {
        if !self.viewIsAuthenticated {
            // User has input their current PIN, check it against the stored value
            if (inputPIN == self.manager.userDefaults.valueForKey(kAMPINKey) as? String) {
                // Input PIN is the correct current PIN, advance the screen
                self.viewIsAuthenticated = true
                self.showNewInputViewWithTitle("Enter your new passcode", hintLabelText: "")
            } else {
                // Input PIN is not the current PIN, alert the user
                self.viewController.inputPINWasInvalid()
            }
        } else {
            // Correct current PIN has already been input
            if self.newPIN {
                // New PIN has already been entered once, check the two match
                if self.newPIN == inputPIN {
                    // Verification PIN was the same as the first new PIN, update the value
                    self.manager.userDefaults.setValue(inputPIN, forKey: kAMPINKey)
                    self.manager.userDefaults.synchronize()
                    // and alert the delgate
                    self.updateDelegate?.PINWasUpdated(inputPIN)
                } else {
                    self.newPIN = nil
                    self.showNewInputViewWithTitle("Enter your new passcode", hintLabelText: "Passcodes did not match. Try again.")
                }
            } else {
                // The new PIN has not been input yet, or the user put in 2 PINs that didn't match
                self.newPIN = inputPIN
                self.showNewInputViewWithTitle("Re-enter your new passcode", hintLabelText: "")
            }
        }
    }
}
