//
//  DetailViewModel.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation
import RealmSwift

class DetailViewModel {
    private(set) var titleText: String = ""
    private(set) var totalUsageText: String = ""
    private(set) var cellHeight = 60
    private(set) var tableViewHeight = 100
    
    private var yearRecord: YearRecord
    private var quarterRecords = List<QuarterRecord>()
    
    init(_ yearRecord: YearRecord) {
        self.yearRecord = yearRecord
        
        titleText = self.yearRecord.title
        totalUsageText = String(self.yearRecord.total_usage)
        
        quarterRecords = self.yearRecord.quarterRecords
        tableViewHeight = cellHeight * quarterRecords.count
    }
    
    func numberOfRows() -> Int {
        return quarterRecords.count
    }
    
    func getQuarterRecordAt(index: Int) -> QuarterRecord? {
        guard quarterRecords.count > 0 else {
            return nil
        }
        
        return quarterRecords[index]
    }
}
