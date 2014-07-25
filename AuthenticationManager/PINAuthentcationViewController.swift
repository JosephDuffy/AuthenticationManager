//
//  PINAuthentcationViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit
import AudioToolbox

public class PINAuthentcationViewController: AuthenticationViewController, UITextFieldDelegate {
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var PINLabel: UILabel!
    @IBOutlet weak var PINTextBox: UITextField!
    let maxPINLength = 4
    var PINCode: String!
    var animating: Bool = false

    override public func viewDidLoad() {
        super.viewDidLoad()
        println(self.userDefaults)
        self.PINCode = "1234"
//        self.PINCode = self.userDefaults.valueForKey(kAMDefaultPINCodeKey) as String
        println("PIN Code \(self.PINCode)")
        self._authenticationMethod = .PINCode
        self.PINTextBox.delegate = self
        self.PINTextBox.addTarget(self, action: "PINTextFieldEditingChanged:", forControlEvents: .EditingChanged)
        self.PINTextBox.becomeFirstResponder()
    }

    // MARK: - PINTextBox Methods

    public func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let oldLength = self.PINTextBox.text.utf16Count
        let replacementLength = string.utf16Count
        let rangeLength = range.length
        let newLength = oldLength - rangeLength + replacementLength
//        let returnKeyUsed = string.bridgeToObjectiveC().containsString("\n")
        let returnKeyUsed = false
        return newLength <= 4 || returnKeyUsed
    }

    func PINTextFieldEditingChanged(sender: UITextField) {
        assert(sender == self.PINTextBox, "Only the PIN Text Box should call the PINTextFieldEditingChanged: method")
        let inputCodeLength = self.PINTextBox.text.utf16Count
        self.updatePINLabel()
        if inputCodeLength == maxPINLength {
            // Try the authentication code
            self.checkPIN()
        }
    }

    func updatePINLabel() {
        if !self.animating {
            let inputCodeLength = self.PINTextBox.text.utf16Count
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

    func checkPIN() {
        if self.PINTextBox.text == self.PINCode {
            self.delegate?.authenticationDidSucceed()
        } else {
            // Clear the input, allowing the user to type during the animation
            self.PINTextBox.text = ""
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
//            // Clear the input
//            self.PINTextBox.text = ""
//            // Reset the label
//            self.PINLabel.text = "- - - -"
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
