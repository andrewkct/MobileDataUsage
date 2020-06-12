//
//  MobileDataUsageUITests.swift
//  MobileDataUsageUITests
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import XCTest

class MobileDataUsageUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // UI tests must launch the application that they test.
        app = XCUIApplication()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    
    func testHomeView() {
        app.launch()
        XCTAssertTrue(app.isDisplayingHomeView)
        
        let dutv = app.tables["DataUsageTableView"]
        XCTAssertTrue(dutv.exists)
        
        let totalCells = dutv.cells.count
        XCTAssertTrue(totalCells > 0)
        
        for i in 0 ..< totalCells {
            let dutvCell = dutv.cells["DataTableViewCell_\(i)"]
            XCTAssertTrue(dutvCell.exists)
        }
    }
    
    func testTapOnAttention() {
        app.launch()
        XCTAssertTrue(app.isDisplayingHomeView)

        let dutv = app.tables["DataUsageTableView"]
        XCTAssertTrue(dutv.exists)

        let dutvCell = dutv.cells["DataTableViewCell_3"]
        XCTAssertTrue(dutvCell.exists)

        let imgView = dutvCell.images["AttentionImageView"]
        XCTAssertTrue(imgView.exists)
        imgView.tap()
        
        XCTAssertTrue(app.isDisplayingDetailView)

        let closeBtn = app.buttons["CloseButton"]
        closeBtn.tap()
    }
}

extension XCUIApplication {
    var isDisplayingHomeView: Bool {
        return otherElements["HomeView"].exists
    }
    
    var isDisplayingDetailView: Bool {
        return otherElements["DetailView"].exists
    }
}
