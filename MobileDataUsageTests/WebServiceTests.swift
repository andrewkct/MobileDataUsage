//
//  WebServiceTests.swift
//  MobileDataUsageTests
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import XCTest
@testable import MobileDataUsage

class WebServiceTests: XCTestCase {
    var mobileDataUsageService: MobileDataUsageService!
    
    override func setUp() {
        mobileDataUsageService = MobileDataUsageService()
    }
    
    override func tearDown() {
        mobileDataUsageService = nil
    }
    
    func testMobileDataUsageService() {
        let asyncExpectation = expectation(description: "Async Block Executed")
        
        mobileDataUsageService.getMobileDataUsage(onSuccess: { (mobileDataUsage) in
            XCTAssertNotNil(mobileDataUsage)
            
            let mdu = mobileDataUsage
            XCTAssertEqual(mdu.help, "https://data.gov.sg/api/3/action/help_show?name=datastore_search")
            XCTAssertEqual(mdu.success, true)
            
            let mdur = mobileDataUsage.result
            XCTAssertGreaterThan(mdur.records.count, 0)
            
            let mdurr = mdur.records.first
            let id = mdurr?.id ?? 0
            let quarter = mdurr?.quarter ?? ""
            let volume_of_mobile_data = mdurr?.volume_of_mobile_data ?? ""
            XCTAssertEqual(id, 1)
            XCTAssertEqual(quarter, "2004-Q3")
            XCTAssertEqual(volume_of_mobile_data, "0.000384")
            asyncExpectation.fulfill()
            
        }) { (error) in
            XCTAssertNotNil(error)
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 15.0, handler: nil)
    }
}
