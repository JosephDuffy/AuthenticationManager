//
//  PINSetupViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 27/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class PINSetupViewController: PINViewController, PINViewControllerDelegate {
    var inputPIN: String?
    public var setupDelegate: PINSetupDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        // Setup the label
        self.viewController.textLabel.text = "Enter a passcode"
        self.title = "Enter Passcode"
    }

    public func PINWasInput(PIN: String) {
        if let firstPIN = self.inputPIN {
            // PIN has already been input, check the 2 are equal
            if PIN == firstPIN {
                // Both PINs have been input and are valid, alert the delegate
            } else {
                // Second PIN is invalid, reset the view
                self.inputPIN = nil
            }
        } else {
            // First PIN to be input, save the value
            self.inputPIN = PIN
            // Advance to the next input
            //TODO: Implement this part
            // For now, alert the delegate of the input code
            self.setupDelegate?.setupCompleteWithPIN(self.inputPIN!)
        }
    }
}
