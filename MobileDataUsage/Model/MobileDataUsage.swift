//
//  MobileDataUsage.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

struct MobileDataUsage: Codable {
    let help: String
    let success: Bool
    let result: MobileDataUsageResult
}
