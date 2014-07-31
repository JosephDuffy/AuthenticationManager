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

    init() {
        super.init()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self._authenticationType = .PIN
        self.viewController = self.manager.storyboard.instantiateViewControllerWithIdentifier("PINAuthentication") as PINInputViewController
        self.viewController.delegate = self
        // Add the view controller as a child of this view controller
        self.addChildViewController(self.viewController)
        // Add the view as a subview of this view
        self.view.addSubview(self.viewController.view)
        // Setup the constriants
        self.view.addConstraints([
            NSLayoutConstraint(item: self.viewController.view, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.viewController.view, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.viewController.view, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.viewController.view, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            ])
    }
}
