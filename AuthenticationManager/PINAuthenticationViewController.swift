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
    var PINCode: String?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1)
    }

    func checkPIN() {
//        let inputCode = self.viewController.inputTextField.text
//        if !self.PINCode {
//            // PIN is not set, alert the delegate that a PIN has been input
//            self.delegate?.PINWasInput?(inputCode)
//        } else {
//            // PIN has been set, check it
//            if inputCode == self.PINCode {
//                // Input PIN is correct
//                self.delegate?.authenticationDidSucceed?()
//            } else {
//                // Input PIN is incorrect, update the UI...
//                self.viewController.inputPINWasIncorrect()
//                // ... and alert the delegate
//                self.delegate?.inputPINWasIncorrect?(inputCode)
//            }
//        }
    }
}
