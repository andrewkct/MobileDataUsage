//
//  MobileDataUsageRecord.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

struct MobileDataUsageRecord: Codable {
    let id: Int
    let quarter: String
    let volume_of_mobile_data: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quarter = "quarter"
        case volume_of_mobile_data = "volume_of_mobile_data"
    }
}
