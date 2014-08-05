//
//  PINManager.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 05/08/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit

public class PINManager {
    public class var sharedInstance: PINManager {
        struct Static {
            static let instance: PINManager = PINManager()
        }
        return Static.instance
    }

    private lazy var _PINCache: String? = {
        // Load the value from the keychain
        return JNKeychain.loadValueForKey(kAMPINKey) as? String
    }()

    public var PIN: String? {
        get {
            return self._PINCache
        }
        set {
            if newValue != nil {
                // Check the new value is valid
                if self.PINIsValid(newValue!) {
                    // Save the value to the cache
                    self._PINCache = newValue
                    // Save the new value to the keychain
                    JNKeychain.saveValue(newValue, forKey: kAMPINKey)
                }

            } else {
                // New value is nil
                // Update the cache
                self._PINCache = nil
                // Delete the PIN from the keychain
                JNKeychain.deleteValueForKey(kAMPINKey)
            }
        }
    }

    /// Checks if a provided PIN is valid.
    /// A PIN is defined as being valid if it meets the following criteria:
    /// The PIN is not an empty string
    /// The PIN only contains numeric characters, as defined in the NSCharacterSet.decimalDigitCharacterSet character set
    public func PINIsValid(PIN: String) -> Bool {
        if PIN.isEmpty {
            return false
        }
        let allowedCharacters = NSCharacterSet.decimalDigitCharacterSet()
        let inPINSet = NSCharacterSet(charactersInString: PIN)
        if allowedCharacters.isSupersetOfSet(inPINSet) {
            return true
        }
        return false
    }
}
