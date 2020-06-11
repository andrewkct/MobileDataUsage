//
//  CALayerExt.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 11/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func dropShadow(color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 1, scale: Bool = true) {
        self.shadowOpacity = opacity
        self.shadowOffset = CGSize(width: 0.2, height: 1) // Control spread
        self.shadowRadius = radius // Control blur
        self.shadowColor = color.cgColor
        self.masksToBounds = false
        
        self.shouldRasterize = true
        self.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
