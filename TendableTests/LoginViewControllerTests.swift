//
//  LoginViewControllerTests.swift
//  TendableTests
//
//  Created by Choudhary, Mandar on 23/06/24.
//

import XCTest
@testable import Tendable

final class LoginViewControllerTests: XCTestCase {
    
    var lginVc: LoginViewController = LoginViewController()
    
    override func setUp() {
        super.setUp()
        lginVc.loadViewIfNeeded()
    }
    
    func testInitialSetup_WhenIsRegisterIsTrue() {
        // Given
        lginVc.isRegister = true
        
        // When
        lginVc.initialSetup()
        
        // Then
        XCTAssertEqual(lginVc.titleLable.text, REGISTER, "titleLable text should be set to REGISTER")
        XCTAssertEqual(lginVc.loginBtn.title(for: .normal), REGISTER, "loginBtn title should be set to REGISTER")
    }
    
    func testInitialSetup_WhenIsRegisterIsFalse() {
        // Given
        lginVc.isRegister = false
        
        // When
        lginVc.initialSetup()
        
        // Then
        XCTAssertEqual(lginVc.titleLable.text, LOGIN, "titleLable text should be set to LOGIN")
        XCTAssertEqual(lginVc.loginBtn.title(for: .normal), LOGIN, "loginBtn title should be set to LOGIN")
    }
    
    func testIsValid_WhenEmailAndPasswordAreNotEmpty() {
        // Given
        lginVc.emailIdTxtFld.text = "test@example.com"
        lginVc.passwordTxtFld.text = "password123"
        
        // When
        let result = lginVc.isValid()
        
        // Then
        XCTAssertTrue(result, "isValid should return true when both email and password are not empty")
    }
    
    func testIsValid_WhenEmailIsEmpty() {
        // Given
        lginVc.emailIdTxtFld.text = ""
        lginVc.passwordTxtFld.text = "password123"
        
        // When
        let result = lginVc.isValid()
        
        // Then
        XCTAssertFalse(result, "isValid should return false when email is empty")
    }
    
    func testIsValid_WhenPasswordIsEmpty() {
        // Given
        lginVc.emailIdTxtFld.text = "test@example.com"
        lginVc.passwordTxtFld.text = ""
        
        // When
        let result = lginVc.isValid()
        
        // Then
        XCTAssertFalse(result, "isValid should return false when password is empty")
    }
    
    func testIsValid_WhenBothEmailAndPasswordAreEmpty() {
        // Given
        lginVc.emailIdTxtFld.text = ""
        lginVc.passwordTxtFld.text = ""
        
        // When
        let result = lginVc.isValid()
        
        // Then
        XCTAssertFalse(result, "isValid should return false when both email and password are empty")
    }
    
}
