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
    
    @IBOutlet private weak var tblDetailHeightConstraint: NSLayoutConstraint!
    
    private let detailTableViewCellId = String(describing: DetailTableViewCell.self)
    private let detailTableViewCellHeight = 60
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.bgView.alpha = 0.5
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        bgView.alpha = 0
    }
    
    // MARK: - Configure View
    private func configureView() {
        view.isOpaque = false
        view.backgroundColor = .clear
            
        containerView.layer.cornerRadius = 10.0
        
        tblDetail.backgroundColor = .clear
        tblDetail.isScrollEnabled = false
        tblDetailHeightConstraint.constant = CGFloat(detailTableViewCellHeight * 4)
        
        let dvcNib = UINib(nibName: detailTableViewCellId, bundle: nil)
        tblDetail.register(dvcNib, forCellReuseIdentifier: detailTableViewCellId)
    }
    
    // MARK: - Actions
    @IBAction private func closeAction(sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: detailTableViewCellId, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(detailTableViewCellHeight)
    }
}
