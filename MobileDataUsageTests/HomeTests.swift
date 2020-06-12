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
    
    func testDataTableViewModel() {
        let records = self.getYearRecords()
        XCTAssertNotNil(records)
        
        yearRecords = homeViewModel.filterIntoYearly(records: records, startDate: "2018", endDate: "2018")
        XCTAssertEqual(yearRecords.count, 1)
        
        let yearRecord = yearRecords.first
        let title = yearRecord?.title ?? ""
        let total_usage = yearRecord?.total_usage ?? 0
        let isDecreasing = yearRecord?.isDecreasing ?? false
        
        let vm = DataTableViewModel(yearRecord!)
        XCTAssertEqual(vm.titleText, title)
        XCTAssertEqual(vm.valueText, String(total_usage))
        XCTAssertEqual(vm.isDecreasing, isDecreasing)
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
        let data = readJson(resourceName: sample_filename)
        let mobileDataUsage = parse(data: data)
        let records = mobileDataUsage?.result.records
        return records!
    }
    
    func readJson(resourceName: String) -> Data {
        let bundle = Bundle(for: HomeTests.self)
        guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
            XCTFail("Can't find resource file")
            return Data()
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
            
        } catch let error{
            XCTFail("Unexpected error of getting data from resource file \(error)")
            return Data()
        }
    }

    func parse(data: Data?) -> MobileDataUsage? {
        guard let data = data else {
            XCTFail("No data to parse")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let models = try decoder.decode(MobileDataUsage.self, from: data)
            return models
        
        } catch  {
            XCTFail("Error decoding data")
            return nil
        }
    }
}
