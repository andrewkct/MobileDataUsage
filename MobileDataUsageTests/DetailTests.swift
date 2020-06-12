//
//  DetailTests.swift
//  MobileDataUsageTests
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import XCTest
@testable import MobileDataUsage
@testable import RealmSwift

class DetailTests: XCTestCase {
    var detailViewModel: DetailViewModel!
    var yearRecord: YearRecord!
    var quarterRecords: List<QuarterRecord>!
    var total_usage: Float!
    
    override func setUp() {
        let q1 = QuarterRecord()
        q1.id = "2009-Q1"
        q1.title = "Q1"
        q1.usage = 1.01000
        q1.isDecreasing = false
        
        let q2 = QuarterRecord()
        q2.id = "2009-Q2"
        q2.title = "Q2"
        q2.usage = 2.01000
        q2.isDecreasing = false
        
        let q3 = QuarterRecord()
        q3.id = "2009-Q3"
        q3.title = "Q3"
        q3.usage = 3.01000
        q3.isDecreasing = false
        
        let q4 = QuarterRecord()
        q4.id = "2009-Q4"
        q4.title = "Q4"
        q4.usage = 4.01000
        q4.isDecreasing = false
        
        total_usage = q1.usage + q2.usage + q3.usage + q4.usage
        
        quarterRecords = List<QuarterRecord>()
        quarterRecords.append(objectsIn: [q1, q2, q3, q4])
        
        yearRecord = YearRecord()
        yearRecord.title = "2009"
        yearRecord.total_usage = total_usage
        yearRecord.isDecreasing = false
        yearRecord.quarterRecords = quarterRecords
    }
    
    override func tearDown() {
        detailViewModel = nil
        yearRecord = nil
        quarterRecords = nil
        total_usage = nil
    }
    
    func testDetailViewModel() {
        let vm = DetailViewModel(yearRecord)
        XCTAssertEqual(vm.titleText, "2009")
        XCTAssertEqual(vm.numberOfRows(), 4)
        
        let quarter = vm.getQuarterRecordAt(index: 0)
        let id = quarter?.id ?? ""
        let title = quarter?.title ?? ""
        let usage = quarter?.usage ?? 0
        let isDecreasing = quarter?.isDecreasing ?? false
        XCTAssertEqual(id, "2009-Q1")
        XCTAssertEqual(title, "Q1")
        XCTAssertEqual(usage, 1.01000)
        XCTAssertEqual(isDecreasing, false)
    }
    
    func testDetailTableViewModel() {
        let quarterRecord = quarterRecords[1]
        
        let vm = DetailTableViewModel(quarterRecord)
        XCTAssertEqual(vm.quarterTitleText, "Q2")
        XCTAssertEqual(vm.valueText, String(2.01000))
        XCTAssertEqual(vm.isDecreasing, false)
    }
}
