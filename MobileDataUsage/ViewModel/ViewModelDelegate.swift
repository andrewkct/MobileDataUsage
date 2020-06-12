//
//  BaseViewModel.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func onLoading(_ isLoading: Bool)
}

extension ViewModelDelegate {
    func onLoading(_ isLoading: Bool) { }
}
