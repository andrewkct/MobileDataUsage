//
//  HomeViewController.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 11/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var tblDataUsage: UITableView!
    
    private let dataTableViewCellId = String(describing: DataTableViewCell.self)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Configure View
    private func configureView() {
        tblDataUsage.backgroundColor = .clear
        
        let dtvcNib = UINib(nibName: dataTableViewCellId, bundle: nil)
        tblDataUsage.register(dtvcNib, forCellReuseIdentifier: dataTableViewCellId)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dataTableViewCellId, for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
            
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
}
