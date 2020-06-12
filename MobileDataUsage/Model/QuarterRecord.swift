//
//  QuarterRecord.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation
import RealmSwift

class QuarterRecord: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var usage: Float = 0.0
    @objc dynamic var isDecreasing: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
