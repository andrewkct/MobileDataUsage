//
//  MobileDataUsageResult.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

struct MobileDataUsageResult: Codable {
    let records: [MobileDataUsageRecord]
}
