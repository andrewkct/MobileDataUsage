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
    @IBOutlet private weak var imgViewAttention: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblUsage: UILabel!
    @IBOutlet private weak var lblValue: UILabel!
    
    @IBOutlet private weak var imgViewAttentionWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var lblTitleLeadConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    private func configureView() {
        self.backgroundColor = .clear
        
        containerView.layer.dropShadow(opacity: 0.25, radius: 3)
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.3
        containerView.layer.cornerRadius = 5
    }
}
