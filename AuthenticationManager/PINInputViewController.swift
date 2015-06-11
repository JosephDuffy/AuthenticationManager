//
//  PINViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 27/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

/**
A class for containing the method of allowing the user to input a PIN. On its own this class does not do much,
but rather it is added to another view controller that will do anything it needs to with the user's input
*/
class PINInputViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var PINLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    weak var delegate: PINViewControllerDelegate?
    let maxPINLength = 4
    private var animating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.hintLabel.text = ""
        self.inputTextField.delegate = self
        self.inputTextField.addTarget(self, action: "inputTextFieldEditingChanged:", forControlEvents: .EditingChanged)
        self.inputTextField.becomeFirstResponder()
    }

    // MARK: - PINTextBox Methods

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Check that the input text is valid
        if PINManager.sharedInstance.PINIsValid(string) {
            guard let oldLength = self.inputTextField.text?.utf16.count else { return false }

            let replacementLength = string.utf16.count
            let rangeLength = range.length
            let newLength = oldLength - rangeLength + replacementLength
            return newLength <= self.maxPINLength
        } else {
            return false
        }
    }

    func inputTextFieldEditingChanged(sender: UITextField) {
        assert(sender == self.inputTextField, "Only the PIN Text Box should call the PINTextFieldEditingChanged: method")

        guard let inputTextFieldText = self.inputTextField.text else { return }
        let inputCodeLength = inputTextFieldText.utf16.count
        self.updatePINLabel()
        if inputCodeLength == maxPINLength {
            self.delegate?.PINWasInput?(inputTextFieldText)
        }
    }

    func updatePINLabel() {
        if !self.animating {
            guard let inputCodeLength = self.inputTextField.text?.utf16.count else { return }
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

    func inputPINWasInvalid() {
        // Clear the input, allowing the user to type during the animation
        self.inputTextField.text = ""
        // Set that an animation is happening
        self.animating = true
        // Animate the label
        let xMovement: CGFloat = 10.0;
        let translateLeft: CGAffineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -xMovement, 0.0);
        let translateRight: CGAffineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, xMovement, 0.0);
        self.PINLabel.transform = translateLeft;
        UIView.animateWithDuration(0.07, delay: 0.0, options: [.Autoreverse, .Repeat], animations: {() -> Void in
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
            })
    }
}
