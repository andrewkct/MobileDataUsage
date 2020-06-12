//
//  DataTableViewModel.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

class DataTableViewModel {
    let usageTitleText: String = "Total usage:"
    
    private(set) var titleText: String = ""
    private(set) var valueText: String = ""
    
    private(set) var isDecreasing = false
    private(set) var imageWidthConstant = 0
    private(set) var titleLeadConstant = 5
    
    init(_ yearRecord: YearRecord) {
        titleText = yearRecord.title
        valueText = String(yearRecord.total_usage)
        
        isDecreasing = yearRecord.isDecreasing
        var imageWidth = 25
        var titleLead = 5
        
        if !isDecreasing {
            imageWidth = 0
            titleLead = 0
        }
        
        imageWidthConstant = imageWidth
        titleLeadConstant = titleLead
    }
}
