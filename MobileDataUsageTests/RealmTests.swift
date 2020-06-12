//
//  RealmTests.swift
//  MobileDataUsageTests
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import XCTest
@testable import MobileDataUsage
@testable import RealmSwift

class RealmTests: XCTestCase {
    var realmManager: RealmManager!
    var yearRecords: [YearRecord]!
    var quarterRecords: List<QuarterRecord>!
    var total_usage: Float!
    
    override func setUp() {
        realmManager = RealmManager()
        
        let q1 = QuarterRecord()
        q1.id = "2019-Q1"
        q1.title = "Q1"
        q1.usage = 1.18000
        q1.isDecreasing = false
        
        let q2 = QuarterRecord()
        q2.id = "2019-Q2"
        q2.title = "Q2"
        q2.usage = 2.00000
        q2.isDecreasing = false
        
        let q3 = QuarterRecord()
        q3.id = "2019-Q3"
        q3.title = "Q3"
        q3.usage = 1.00000
        q3.isDecreasing = true
        
        let q4 = QuarterRecord()
        q4.id = "2019-Q4"
        q4.title = "Q4"
        q4.usage = 3.01000
        q4.isDecreasing = false
        
        total_usage = q1.usage + q2.usage + q3.usage + q4.usage
        
        quarterRecords = List<QuarterRecord>()
        quarterRecords.append(objectsIn: [q1, q2, q3, q4])
        
        let yr = YearRecord()
        yr.title = "2019"
        yr.total_usage = total_usage
        yr.isDecreasing = true
        yr.quarterRecords = quarterRecords
        
        yearRecords = []
        yearRecords.append(yr)
    }
    
    override func tearDown() {
        realmManager = nil
        yearRecords = nil
        quarterRecords = nil
        total_usage = nil
    }
    
    func testAddYearRecords() {
        realmManager.addYearRecordToRealm(yearRecords)
        
        let results = realmManager.getYearRecordsFromRealm()
        XCTAssertEqual(results.count, 1)
    }
    
    func testGetYearRecord() {
        testAddYearRecords()
        
        let results = realmManager.getYearRecordsFromRealm()
        
        let yr = results.first
        let title = yr?.title ?? ""
        let totalUsage = yr?.total_usage ?? 0
        let isDecreasing = yr?.isDecreasing ?? false
        let quarterRecords = yr?.quarterRecords ?? List<QuarterRecord>()
        XCTAssertEqual(title, "2019")
        XCTAssertEqual(totalUsage, total_usage)
        XCTAssertEqual(isDecreasing, true)
        XCTAssertEqual(quarterRecords.count, 4)
    }
    
    func testDeleteAllRecords() {
        realmManager.deleteAllData()
        
        let results = realmManager.getYearRecordsFromRealm()
        XCTAssertEqual(results.count, 0)
    }
}
