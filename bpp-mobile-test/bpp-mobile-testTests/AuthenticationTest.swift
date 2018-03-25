//
//  AuthenticationTest.swift
//  bpp-mobile-testTests
//
//  Created by Gabriel Carvalho on 25/03/2018.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import XCTest
@testable import bpp_mobile_test

class AuthenticationTest: XCTestCase {
    
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.expectation = nil
    }
    
    func test_1_LoginBadPassword() {
        let login = "waldisney@brasilprepagos.com.br"
        let password = "BadPassword"
        
        self.expectation = self.expectation(description: "LoginFailure")
        
        LoginApi.sharedInstance.authenticateUser(login, password, callback: {
            possibleError in
            
            guard possibleError != nil else {
                XCTFail("Authentication should fail for this test")
                return
            }
            
            self.expectation!.fulfill()
            
        })
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    func test_2_Login() {
        let login = "waldisney@brasilprepagos.com.br"
        let password = "Br@silPP123"
        
        self.expectation = self.expectation(description: "LoginSuccess")
        
        LoginApi.sharedInstance.authenticateUser(login, password) {
            (possibleError) in
            
            guard possibleError == nil else {
                XCTFail("Authentication should success for this test")
                return
            }
            
            self.expectation!.fulfill()
        }
        
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    func test_3_LoginBadLogin() {
        let login = "waldisney@dev-bpp.com.br"
        let password = "Br@silPP123"
        
        self.expectation = self.expectation(description: "LoginFailure")
        
        LoginApi.sharedInstance.authenticateUser(login, password, callback: {
            possibleError in
            
            guard possibleError != nil else {
                XCTFail("Authentication should fail for this test")
                return
            }
            
            self.expectation!.fulfill()
            
        })
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    func test_4_LoginBadLoginAndPassword() {
        let login = "waldisney@dev-bpp.com.br"
        let password = "BadPassword"
        
        self.expectation = self.expectation(description: "LoginFailure")
        
        LoginApi.sharedInstance.authenticateUser(login, password, callback: {
            possibleError in
            
            guard possibleError != nil else {
                XCTFail("Authentication should fail for this test")
                return
            }
            
            self.expectation!.fulfill()
            
        })
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
