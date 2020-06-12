//
//  YearRecord.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

struct YearRecord {
    var title: String = ""
    var total_usage: Float = 0.0
    var isDecreasing: Bool = false
    var quarterRecords: [QuarterRecord] = []
}
