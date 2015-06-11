//
//  AuthenticationViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class AuthenticationViewController: UIViewController {
    public var delegate: AuthenticationDelegate?

    public let authenticationType: AuthenticationType

    public required init(authenticationType: AuthenticationType) {
        self.authenticationType = authenticationType

        super.init(nibName: nil, bundle: nil)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func viewInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelButtonWasPressed")
        return navigationController
    }

    public func cancelButtonWasPressed() {
        self.delegate?.authenticationWasCanceled?(self)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
