//
//  DataTableViewCell.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 11/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblUsage: UILabel!
    @IBOutlet private weak var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    private func configureView() {
        self.backgroundColor = .clear
        
        containerView.layer.dropShadow()
    }
}
