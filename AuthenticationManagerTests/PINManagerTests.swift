//
//  PINManagerTests.swift
//  AuthenticationManager
//
//  Created by Joseph Duffy on 05/08/2014.
//  Copyright (c) 2014 Yetii Ltd. All rights reserved.
//

import UIKit
import XCTest
import AuthenticationManager

class PINManagerTests: XCTestCase {
    var preTestsPIN: String?

    override func setUp() {
        super.setUp()
        // Save the current PIN
        self.preTestsPIN = JNKeychain.loadValueForKey(kAMPINKey) as? String
    }
    
    override func tearDown() {
        // Set the PIN back to the pre-tests PIN
        JNKeychain.saveValue(self.preTestsPIN, forKey: kAMPINKey)
        super.tearDown()
    }

    func testClassIsSingleton() {
        let firstInstance = PINManager.sharedInstance
        let secondInstance = PINManager.sharedInstance
        XCTAssertTrue(firstInstance === secondInstance, "The same instance of PINManager should always be returned from the sharedInstance property")
    }

    func testSettingValidPIN() {
        let PINToSave = "1234"
        let manager = PINManager.sharedInstance
        manager.PIN = PINToSave
        let savedPIN = JNKeychain.loadValueForKey(kAMPINKey) as? String
        XCTAssertNotNil(savedPIN, "Setting the PIN should result in a non-nil value in the keychain")
        XCTAssertEqual(savedPIN!, PINToSave, "PIN in keychain should be the same as original PIN")
    }

    func testSettingInvalidPIN() {
        let invalidPIN = "invalid"
        let manager = PINManager.sharedInstance
        // Delete the stored PIN
        manager.PIN = nil
        // Set the PIN to the invalid value
        manager.PIN = invalidPIN
        let cachedPIN = manager.PIN
        let savedPIN = JNKeychain.loadValueForKey(kAMPINKey) as? String
        XCTAssertNil(cachedPIN, "Setting an invalid PIN should leave the cached PIN as nil")
        XCTAssertNil(savedPIN, "Setting an invalid PIN should leave the PIN in the keychain as nil")
    }

    func testGettingCachedValue() {
        let PINToSave = "1234"
        let manager = PINManager.sharedInstance
        manager.PIN = PINToSave
        let cachedPIN = manager.PIN
        XCTAssertNotNil(cachedPIN, "Setting the PIN should result in a non-nil cached value")
        XCTAssertEqual(cachedPIN!, PINToSave, "Cached PIN should be the same as original PIN")
    }

    func testDeletingPIN() {
        let manager = PINManager.sharedInstance
        // Enusure the PIN has a value
        manager.PIN = "1234"
        // Delegate the PIN
        manager.PIN = nil
        XCTAssertNil(manager.PIN, "Cached PIN should be nil")
        XCTAssertNil(JNKeychain.loadValueForKey(kAMPINKey), "Value in keychain should be nil")
    }

    func testValidPINValues() {
        let manager = PINManager.sharedInstance
        let romanNumbersPIN = "0123456789"
        let arabicNumbersPIN = "٠١٢٣٤٥٦٧٨٩"
        XCTAssertTrue(manager.PINIsValid(romanNumbersPIN), "PIN \"\(romanNumbersPIN)\" should be valid")
        XCTAssertTrue(manager.PINIsValid(arabicNumbersPIN), "PIN \"\(arabicNumbersPIN)\" should be valid")
    }

    func testInvalidPINValues() {
        let manager = PINManager.sharedInstance
        let emptyString = ""
        let nonNumericCharacters = "invalid"
        let alphanumericMixture = "12invalid34"
        XCTAssertFalse(manager.PINIsValid(emptyString), "PIN \"\(emptyString)\" should be invalid")
        XCTAssertFalse(manager.PINIsValid(nonNumericCharacters), "PIN \"\(nonNumericCharacters)\" should be invalid")
        XCTAssertFalse(manager.PINIsValid(alphanumericMixture), "PIN \"\(alphanumericMixture)\" should be invalid")
    }

    func testGettingValueFromCachePerformance() {
        // Ensure the value is pre-cached and has a value
        PINManager.sharedInstance.PIN = "1234"
        self.measureBlock() {
            for _ in 0...2500 {
                // Load the cached value from the manager
                _ = PINManager.sharedInstance.PIN
            }
        }
    }

    func testGettingValueDirectlyFromKeychainPerformance() {
        // Ensure the keychain has a value
        JNKeychain.saveValue("1234", forKey: kAMPINKey)
        self.measureBlock() {
            for _ in 0...2500 {
                _ = JNKeychain.loadValueForKey(kAMPINKey) as? String
            }
        }
    }

    func testGettingNilValueFromCachePerformance() {
        // Ensure the value is pre-cached and has a value
        PINManager.sharedInstance.PIN = nil
        self.measureBlock() {
            for _ in 0...2500 {
                // Load the cached value from the manager
                _ = PINManager.sharedInstance.PIN
            }
        }
    }

    func testGettingNilValueDirectlyFromKeychainPerformance() {
        // Ensure the keychain has a value
        JNKeychain.deleteValueForKey(kAMPINKey)
        self.measureBlock() {
            for _ in 0...2500 {
                _ = JNKeychain.loadValueForKey(kAMPINKey) as? String
            }
        }
    }
}
