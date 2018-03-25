//
//  TimeLineTests.swift
//  bpp-mobile-testTests
//
//  Created by Gabriel Carvalho on 25/03/2018.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import XCTest
@testable import bpp_mobile_test

class TimeLineTests: XCTestCase {
    
    var expectation: XCTKVOExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func timeLineFetchedSuccessfully() {
        TimeLineApi.sharedInstance.fetchTimeLine {
            (possibleResults, possibleErrors) in
            
            guard possibleErrors != nil && possibleResults != nil else {
                XCTFail("APi should not return errors and have to return results for this test")
                return
            }
            
            self.expectation!.fulfill()
        }
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
}
