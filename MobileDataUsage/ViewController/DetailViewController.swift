//
//  DetailViewController.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 11/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var tblDetail: UITableView!
    @IBOutlet private weak var lblTotal: UILabel!
    @IBOutlet private weak var btnClose: UIButton!
    
    @IBOutlet private weak var tblDetailHeightConstraint: NSLayoutConstraint!
    
    private let detailTableViewCellId = String(describing: DetailTableViewCell.self)
  
    var detailViewModel: DetailViewModel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Configure View
    private func configureView() {
        view.isOpaque = false
        view.backgroundColor = .clear
        view.accessibilityIdentifier = "DetailView"
            
        containerView.layer.cornerRadius = 10.0
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle.text = detailViewModel.titleText
        lblTotal.text = detailViewModel.totalUsageText
        
        let dvcNib = UINib(nibName: detailTableViewCellId, bundle: nil)
        tblDetail.register(dvcNib, forCellReuseIdentifier: detailTableViewCellId)
        tblDetail.backgroundColor = .clear
        tblDetail.isScrollEnabled = false
        tblDetailHeightConstraint.constant = CGFloat(detailViewModel.tableViewHeight)
        
        btnClose.accessibilityIdentifier = "CloseButton"
    }
    
    // MARK: - Actions
    @IBAction private func closeAction(sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: detailTableViewCellId, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        if let quarterRecord = detailViewModel.getQuarterRecordAt(index: indexPath.row) {
            let detailTableViewModel = DetailTableViewModel(quarterRecord)
            cell.set(viewModel: detailTableViewModel, indexPath: indexPath)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(detailViewModel.cellHeight)
    }
}
