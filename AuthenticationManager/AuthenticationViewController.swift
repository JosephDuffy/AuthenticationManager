//
//  AuthenticationViewController.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class AuthenticationViewController: UIViewController {
//    public var delegate: AuthenticationDelegate?
    lazy var manager: AuthenticationManager = {
    return AuthenticationManager.sharedInstance
    }()
    internal var _authenticationType: AuthenticationType!
    var authenticationType: AuthenticationType {
    get {
        return self._authenticationType
    }
    }
    var userDefaults: NSUserDefaults!

    public init() {
        super.init(nibName: nil, bundle: nil)
        var manager = AuthenticationManager.sharedInstance
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    public func viewInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelButtonWasPressed")
        return navigationController
    }

    public func cancelButtonWasPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
