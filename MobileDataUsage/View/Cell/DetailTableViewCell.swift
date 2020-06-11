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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }

    private func configureView() {
        
    }
}
