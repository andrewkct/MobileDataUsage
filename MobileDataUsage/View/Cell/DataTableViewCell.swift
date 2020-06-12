//
//  DataTableViewCell.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 11/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import UIKit

protocol DataTableViewCellDelegate: class {
    func didTappedOnAttentionAt(indexPath: IndexPath)
}

class DataTableViewCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imgViewAttention: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblUsage: UILabel!
    @IBOutlet private weak var lblValue: UILabel!
    
    @IBOutlet private weak var imgViewAttentionWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var lblTitleLeadConstraint: NSLayoutConstraint!
    
    weak var delegate: DataTableViewCellDelegate?
    var viewModel: DataTableViewModel?
    private var indexPath: IndexPath?
    
    func set(_ delegate: DataTableViewCellDelegate?,
             viewModel: DataTableViewModel? = nil,
             indexPath: IndexPath? = nil) {
        
        self.delegate = delegate
        self.viewModel = viewModel
        self.indexPath = indexPath
        
        if let vm = viewModel {
            lblTitle.text = vm.titleText
            lblUsage.text = vm.usageTitleText
            lblValue.text = vm.valueText
            
            imgViewAttention.isHidden = !vm.isDecreasing
            imgViewAttentionWidthConstraint.constant = CGFloat(vm.imageWidthConstant)
            lblTitleLeadConstraint.constant = CGFloat(vm.titleLeadConstant)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    private func configureView() {
        backgroundColor = .clear
        
        containerView.layer.dropShadow(opacity: 0.25, radius: 3)
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.3
        containerView.layer.cornerRadius = 5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnAttentionAction(sender:)))
        imgViewAttention.addGestureRecognizer(tapGesture)
        imgViewAttention.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    @objc private func tapOnAttentionAction(sender: Any?) {
        if let indexPath = indexPath {
            self.delegate?.didTappedOnAttentionAt(indexPath: indexPath)
        }
    }
}
