//
//  HomeViewModel.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: ViewModelDelegate {
    func didGetMobileDataUsage()
    func didGetMobileDataUsageWith(error: String)
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    
    private let mobileDataUsageService: MobileDataUsageService!
    private var yearRecords = [YearRecord]()
    
    init(_ delegate: HomeViewModelDelegate? = nil) {
        self.delegate = delegate
        self.mobileDataUsageService = MobileDataUsageService()
    }
    
    func fetchYearlyMobileDataUsage() {
        self.delegate?.onLoading(true)
        
        mobileDataUsageService.getMobileDataUsage(onSuccess: { [weak self] (mobileDataUsage: MobileDataUsage) in
            
            let mobileDataUsageRecords = mobileDataUsage.result.records
            self?.yearRecords = HomeViewModel.filterIntoYearly(records: mobileDataUsageRecords)
            
            self?.delegate?.onLoading(false)
            self?.delegate?.didGetMobileDataUsage()
            
        }) { [weak self] (error) in
            self?.delegate?.onLoading(false)
            self?.delegate?.didGetMobileDataUsageWith(error: error)
        }
    }
    
    // MARK: - Filter records into yearly
    static func filterIntoYearly(records: [MobileDataUsageRecord], startDate: String = "2008", endDate: String = "2018") -> [YearRecord] {
        
        guard records.count > 0 else {
            return []
        }
        
        var yearRecords = [YearRecord]()
        var quarterRecords = [QuarterRecord]()
        let total_quarter = 4
        var total_usage: Float = 0.0
        var previous_usage: Float = 0.0
        var isDecreasing = false
        var isYearHasADecreasingUsage = false
        var counter = 0
        
        for i in 0 ..< records.count {
            let quarter = records[i].quarter
            let vol_of_mobile_data = records[i].volume_of_mobile_data
            
            let arrSplit = quarter.split(separator: "-")
            let year = String(arrSplit.first ?? "")
            let quarterTitle = String(arrSplit.last ?? "")
            let usage = Float(vol_of_mobile_data) ?? 0.0
            
            if year >= startDate && year <= endDate {
                counter += 1
                
                var quarterRecord = QuarterRecord()
                quarterRecord.title = quarterTitle
                quarterRecord.usage = usage
              
                isDecreasing = previous_usage > usage
                quarterRecord.isDecreasing = isDecreasing
                
                if isDecreasing {
                    isYearHasADecreasingUsage = isDecreasing
                }
                
                quarterRecords.append(quarterRecord)
                
                previous_usage = usage
                total_usage += usage
                
                if counter == total_quarter { // Reach all quarters
                    var yearRecord = YearRecord()
                    yearRecord.title = year
                    yearRecord.total_usage = total_usage
                    yearRecord.isDecreasing = isYearHasADecreasingUsage
                    yearRecord.quarterRecords = quarterRecords
                    
                    yearRecords.append(yearRecord)
                    
                    // Reset
                    counter = 0
                    total_usage = 0
                    previous_usage = 0
                    isYearHadADecreasingUsage = false
                    quarterRecords = []
                }
            }
        }
        
        return yearRecords
    }
    
    func numberOfRows() -> Int {
        return yearRecords.count
    }
    
    func getYearRecordAt(index: Int) -> YearRecord? {
        guard yearRecords.count > 0 else {
            return nil
        }
        
        return yearRecords[index]
    }
}
