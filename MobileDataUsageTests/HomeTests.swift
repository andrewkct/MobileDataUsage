//
//  HomeTests.swift
//  MobileDataUsageTests
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import XCTest
@testable import MobileDataUsage
@testable import RealmSwift

class HomeTests: XCTestCase {
    var quarterRecords: List<QuarterRecord>!
    var yearRecords: [YearRecord]!
    var homeViewModel: HomeViewModel!
    
    override func setUp() {
        homeViewModel = HomeViewModel(self)
    }
    
    override func tearDown() {
        quarterRecords = nil
        yearRecords = nil
        homeViewModel = nil
    }

    func testYearRecords() {
        let records = self.getYearRecords()
        XCTAssertNotNil(records)
        
        yearRecords = homeViewModel.filterIntoYearly(records: records)
        XCTAssertEqual(yearRecords.count, 11)
        
        let yearRecord = yearRecords.first
        let title = yearRecord?.title ?? ""
        let total_usage = yearRecord?.total_usage ?? 0
        let isDecreasing = yearRecord?.isDecreasing ?? true
        XCTAssertEqual(title, "2008")
        XCTAssertEqual(total_usage, 1.543719)
        XCTAssertEqual(isDecreasing, false)
    }
    
    func testQuarterRecords() {
        testYearRecords()
        
        quarterRecords = yearRecords.first?.quarterRecords
        XCTAssertEqual(quarterRecords.count, 4)
        
        let qr = quarterRecords[0]
        let id = qr.id
        let title = qr.title
        let usage = qr.usage
        let isDecreasing = qr.isDecreasing
        XCTAssertEqual(id, "2008-Q1")
        XCTAssertEqual(title, "Q1")
        XCTAssertEqual(usage, 0.171586)
        XCTAssertEqual(isDecreasing, false)
    }
    
    func testFilterIntoYearly() {
        let records = self.getYearRecords()
        XCTAssertNotNil(records)
        
        yearRecords = homeViewModel.filterIntoYearly(records: records, startDate: "2011", endDate: "2011")
        XCTAssertEqual(yearRecords.count, 1)
        
        let yearRecord = yearRecords.first
        let title = yearRecord?.title ?? ""
        let total_usage = yearRecord?.total_usage ?? 0
        let isDecreasing = yearRecord?.isDecreasing ?? false
        XCTAssertEqual(title, "2011")
        XCTAssertEqual(total_usage, 14.638703)
        XCTAssertEqual(isDecreasing, true)
    }
    
    
}

// MARK: - HomeViewModelDelegate
extension HomeTests: HomeViewModelDelegate {
    func didGetMobileDataUsage() {}
    func didGetMobileDataUsageWith(error: String) {}
}

extension HomeTests {
    func getYearRecords() -> [MobileDataUsageRecord] {
        let sample_filename = "sample_data"
        let jsonData = readJson(resourceName: sample_filename)
        let mobileDataUsage = parse(jsonData: jsonData)
        let records = mobileDataUsage?.result.records
        return records!
    }
    
    func readJson(resourceName: String) -> Data {
        let bundle = Bundle(for: HomeTests.self)
        guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
            return Data()
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
            
        } catch {
            return Data()
        }
    }

    func parse(jsonData: Data?) -> MobileDataUsage? {
        guard let data = jsonData else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let models = try decoder.decode(MobileDataUsage.self, from: data)
            return models
        
        } catch  {
            return nil
        }
    }
}
