//
//  PINSetupDelegate.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 28/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public protocol PINSetupDelegate {
    func setupCompleteWithPIN(PIN: String)
}
