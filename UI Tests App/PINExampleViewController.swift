//
//  PINExampleViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 11/06/2015.
//  Copyright © 2015 Yetii Ltd. All rights reserved.
//

import UIKit
import AuthenticationManager

class PINExampleViewController: UIViewController, AuthenticationDelegate, PINSetupDelegate, PINUpdateDelegate, PINAuthenticationDelegate {

    @IBOutlet weak var currentCodeLabel: UILabel!
    @IBOutlet weak var setCodeButton: UIButton!
    @IBOutlet weak var updateCodeButton: UIButton!
    @IBOutlet weak var testCodeButton: UIButton!
    @IBOutlet weak var lastTestResultLabel: UILabel!
    @IBOutlet weak var resetPINButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //        println(AuthenticationManager.sharedInstance)
        //        self.manager = AuthenticationManager.sharedInstance
        // Setup the buttons and labels
        self.updateUI()
    }

    func updateUI() {
        if let currentCode = PINManager.sharedInstance.PIN {
            self.currentCodeLabel.text = "Current PIN: \(currentCode)"
            self.setCodeButton.enabled = false
            self.updateCodeButton.enabled = true
            self.testCodeButton.enabled = true
            self.resetPINButton.enabled = true
        } else {
            // No PIN code has been set yet
            self.currentCodeLabel.text = "Current PIN: Not Set"
            self.setCodeButton.enabled = true
            self.updateCodeButton.enabled = false
            self.testCodeButton.enabled = false
            self.resetPINButton.enabled = false
        }
    }

    /// Button pressed methods

    @IBAction func setCodeButtonWasPressed(sender: UIButton) {
        let viewController = AuthenticationManager.sharedInstance.getAuthenticationSetupViewControllerForType(.PIN) as! PINSetupViewController
        viewController.delegate = self
        viewController.setupDelegate = self
        self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
    }

    @IBAction func updateCodeButtonWasPressed(sender: UIButton) {
        let viewController = AuthenticationManager.sharedInstance.getAuthenticationUpdateViewControllerForType(.PIN) as! PINUpdateViewController
        viewController.delegate = self
        viewController.updateDelegate = self
        self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
    }

    @IBAction func testCodeButtonWasPressed(sender: UIButton) {
        let viewController = AuthenticationManager.sharedInstance.getAuthenticationViewControllerForType(.PIN) as! PINAuthenticationViewController
        viewController.delegate = self
        viewController.authenticationDelegate = self
        self.presentViewController(viewController.viewInNavigationController(), animated: true, completion: nil)
    }

    @IBAction func resetPINButtonWasPressed(sender: UIButton) {
        PINManager.sharedInstance.PIN = nil
        self.updateUI()
    }

    /// AuthenticationDelegate methods

    func authenticationWasCanceled(viewController: AuthenticationViewController) {
        if viewController is PINAuthenticationViewController {
            self.lastTestResultLabel.text = "Last Result: Canceled"
        }
    }

    /// PINSetupDelegate methods

    func setupCompleteWithPIN(PIN: String) {
        // Remove the popup view
        self.dismissViewControllerAnimated(true, completion: nil)
        // Update the UI
        self.updateUI()
    }

    /// PINModifyDelegate methods

    func PINWasUpdated(newPIN: String) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // Update the UI
        self.updateUI()
    }

    /// PINAuthenticationDelegate methods

    func authenticationDidSucceed() {
        self.lastTestResultLabel.text = "Last Result: Authenticated"
        self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func inputPINWasIncorrect(PIN: String) {
        self.lastTestResultLabel.text = "Last Result: Input PIN was incorrect"
    }

    func PINWasInput(PIN: String) {
        self.lastTestResultLabel.text = "Last Result: PIN was input"
    }

}
