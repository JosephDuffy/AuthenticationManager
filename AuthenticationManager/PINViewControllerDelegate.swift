//
//  PINViewControllerDelegate.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 23/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

@objc public protocol PINViewControllerDelegate {
    optional func PINWasInput(PIN: String)
}
