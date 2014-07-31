//
//  PINViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 27/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit
import AudioToolbox

class PINInputViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var PINLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    var delegate: PINViewControllerDelegate?
    let maxPINLength = 4
    var animating: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inputTextField.delegate = self
        self.inputTextField.addTarget(self, action: "inputTextFieldEditingChanged:", forControlEvents: .EditingChanged)
        self.inputTextField.becomeFirstResponder()
    }

    // MARK: - PINTextBox Methods

    public func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let oldLength = self.inputTextField.text.utf16Count
        let replacementLength = string.utf16Count
        let rangeLength = range.length
        let newLength = oldLength - rangeLength + replacementLength
        //        let returnKeyUsed = string.bridgeToObjectiveC().containsString("\n")
        let returnKeyUsed = false
        return newLength <= 4 || returnKeyUsed
    }

    func inputTextFieldEditingChanged(sender: UITextField) {
        assert(sender == self.inputTextField, "Only the PIN Text Box should call the PINTextFieldEditingChanged: method")
        let inputCodeLength = self.inputTextField.text.utf16Count
        self.updatePINLabel()
        println("Got a PIN of length \(inputCodeLength)")
        if inputCodeLength == maxPINLength {
            self.delegate?.PINWasInput?(self.inputTextField.text)
            // Try the authentication code
//            self.checkPIN()
        }
    }

    func updatePINLabel() {
        if !self.animating {
            let inputCodeLength = self.inputTextField.text.utf16Count
            var passwordLabelText = "";
            for i in 1...maxPINLength {
                if i <= inputCodeLength {
                    passwordLabelText += "●"
                } else {
                    passwordLabelText += "-"
                }
                if i != maxPINLength {
                    passwordLabelText += " "
                }
            }
            self.PINLabel.text = passwordLabelText
        }
    }

    public func inputPINWasInvalid() {
        // Clear the input, allowing the user to type during the animation
        self.inputTextField.text = ""
        // Set that an animation is happening
        self.animating = true
        // Animate the label
        let xMovement: CGFloat = 10.0;
        let translateLeft: CGAffineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -xMovement, 0.0);
        let translateRight: CGAffineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, xMovement, 0.0);
        self.PINLabel.transform = translateLeft;
        UIView.animateWithDuration(0.07, delay: 0.0, options: .Autoreverse | .Repeat, animations: {() -> Void in
            UIView.setAnimationRepeatCount(2.0)
            self.PINLabel.transform = translateRight
            }, completion:{ (finished: Bool) -> Void in
                if finished {
                    UIView.animateWithDuration(0.05, delay: 0.0, options: .BeginFromCurrentState, animations: {() -> Void in
                        self.PINLabel.transform = CGAffineTransformIdentity
                        }, completion: { (finished: Bool) -> Void in
                            if finished {
                                // Mark the animation as complete
                                self.animating = false
                                // Update the label
                                self.updatePINLabel()
                            }
                        })
                }
            });
        // Vibrate the device
        //        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
