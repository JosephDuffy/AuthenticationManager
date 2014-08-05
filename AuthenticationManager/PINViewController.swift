//
//  PINViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 30/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

/// A generic view controller for use with the PIN authentication method
public class PINViewController: AuthenticationViewController, PINViewControllerDelegate {
    var viewController: PINInputViewController!

    override init() {
        super.init()
    }

    required public init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self._authenticationType = .PIN
        self.viewController = addNewInputViewController()
    }

    private func addNewInputViewController() -> PINInputViewController {
        let newInputViewController = self.manager.storyboard.instantiateViewControllerWithIdentifier("PINAuthentication") as PINInputViewController
        newInputViewController.delegate = self
        // Add the view controller as a child of this view controller
        self.addChildViewController(newInputViewController)
        // Add the view as a subview of this view
        self.view.addSubview(newInputViewController.view)
        // Setup the constriants
        self.view.addConstraints([
            NSLayoutConstraint(item: newInputViewController.view, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: newInputViewController.view, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: newInputViewController.view, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: newInputViewController.view, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
        return newInputViewController
    }

    internal func showNewInputViewWithTitle(title: String, hintLabelText: String) {
        // Keep a pointer to the old PIN view controller
        let oldViewController = self.viewController
        // Create a new view controller
        self.viewController = addNewInputViewController()
        self.viewController.textLabel.text = title
        self.viewController.hintLabel.text = hintLabelText
        self.view.layoutIfNeeded()
        let newViewControllerOriginalFrame = self.viewController.view.frame
        var modifiedNewControllerFrame = newViewControllerOriginalFrame
        modifiedNewControllerFrame.origin.x = modifiedNewControllerFrame.size.width
        self.viewController.view.frame = modifiedNewControllerFrame
        UIView.animateWithDuration(0.5, animations: {() -> Void in
            var modifiedFrame = oldViewController.view.frame
            modifiedFrame.origin.x = -modifiedFrame.size.width
            oldViewController.view.frame = modifiedFrame
            self.viewController.view.frame = newViewControllerOriginalFrame
            self.view.layoutIfNeeded()
            }, completion: {(Bool) -> Void in
                oldViewController.view.removeFromSuperview()
                oldViewController.removeFromParentViewController()
                self.view.layoutIfNeeded()
            })
    }
}
