//
//  DetailTableViewCell.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblUsage: UILabel!
    
    var viewModel: DetailTableViewModel?
    private var indexPath: IndexPath?
    
    func set(viewModel: DetailTableViewModel? = nil,
             indexPath: IndexPath? = nil) {
        
        self.viewModel = viewModel
        self.indexPath = indexPath
        
        if let vm = viewModel {
            lblTitle.text = vm.quarterTitleText
            lblUsage.text = vm.valueText
            
            if vm.isDecreasing {
                lblUsage.textColor = .red
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
