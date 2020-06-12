//
//  YearRecord.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation
import RealmSwift

class YearRecord: Object, Comparable {
    @objc dynamic var title: String = ""
    @objc dynamic var total_usage: Float = 0.0
    @objc dynamic var isDecreasing: Bool = false
    var quarterRecords = List<QuarterRecord>()
    
    override static func primaryKey() -> String? {
        return "title"
    }
    
    static func <(lhs: YearRecord, rhs: YearRecord) -> Bool {
        return lhs.title < rhs.title
    }
}
