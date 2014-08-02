//
//  PINModifyDeleage.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 02/08/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import Foundation

public protocol PINUpdateDelegate {
    func PINWasUpdated(newPIN: String)
}