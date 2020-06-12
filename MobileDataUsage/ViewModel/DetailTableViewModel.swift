//
//  DetailTableViewModel.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

class DetailTableViewModel {
    private(set) var quarterTitleText: String = ""
    private(set) var valueText: String = ""
    
    private(set) var isDecreasing = false
    
    init(_ quarterRecord: QuarterRecord) {
        quarterTitleText = quarterRecord.title
        valueText = String(quarterRecord.usage)
        isDecreasing = quarterRecord.isDecreasing
    }
}
