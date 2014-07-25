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
    internal var _authenticationMethod: AuthenticationType!
    var authenticationMethod: AuthenticationType {
    get {
        return self._authenticationMethod
    }
    }
    var userDefaults: NSUserDefaults!

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        var manager = AuthenticationManager.sharedInstance
    }
}
