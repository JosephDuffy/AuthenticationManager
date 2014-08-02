//
//  PINAuthenticationDelegate.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 31/07/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import Foundation

@objc public protocol PINAuthenticationDelegate {
    func authenticationDidSucceed()
    optional func inputPINWasIncorrect(PIN: String)
    optional func PINWasInput(PIN: String)
}
