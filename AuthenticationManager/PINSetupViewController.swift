//
//  PINSetupViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 27/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class PINSetupViewController: PINViewController, PINViewControllerDelegate {
    var firstPIN: String?
    public var setupDelegate: PINSetupDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        // Setup the label
        self.viewController.textLabel.text = "Enter a passcode"
        self.title = "Set Passcode"
    }

    public func PINWasInput(inputPIN: String) {
        if let firstPIN = self.firstPIN {
            // PIN has already been input, check the 2 are equal
            if inputPIN == firstPIN {
                // Both PINs have been input and are valid, save the value
                PINManager.sharedInstance.PIN = inputPIN
                // alert the delegate
                self.setupDelegate?.setupCompleteWithPIN(inputPIN)
            } else {
                // Second PIN is invalid, reset the view
                self.firstPIN = nil
                self.showNewInputViewWithTitle("Set Passcode", hintLabelText: "Passcodes did not match. Try again.")
            }
        } else {
            // First PIN to be input, save the value
            self.firstPIN = inputPIN
            // Advance to the next input
            self.showNewInputViewWithTitle("Re-enter your passcode", hintLabelText: "")
        }
    }
}
