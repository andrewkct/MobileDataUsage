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
    private let refreshControl = UIRefreshControl()
    
    private let dataTableViewCellId = String(describing: DataTableViewCell.self)
    private var homeViewModel: HomeViewModel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homeViewModel = HomeViewModel(self)
        refreshAction()
    }
    
    // MARK: - Configure View
    private func configureView() {
        refreshControl.addTarget(self, action: #selector(refreshAction(sender:)), for: .valueChanged)
        
        let dtvcNib = UINib(nibName: dataTableViewCellId, bundle: nil)
        tblDataUsage.register(dtvcNib, forCellReuseIdentifier: dataTableViewCellId)
        tblDataUsage.backgroundColor = .clear
        tblDataUsage.refreshControl = refreshControl
    }
    
    // MARK: - Actions
    @objc private func refreshAction(sender: Any? = nil) {
        refreshControl.beginRefreshing()
        homeViewModel.fetchYearlyMobileDataUsage()
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dataTableViewCellId, for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        
        if let yearRecord = homeViewModel.getYearRecordAt(index: indexPath.row) {
            let dataTableViewModel = DataTableViewModel(yearRecord)
            cell.set(self, viewModel: dataTableViewModel, indexPath: indexPath)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func onLoading(_ isLoading: Bool) {
        if !isLoading {
            refreshControl.endRefreshing()
        }
    }
    
    func didGetMobileDataUsage() {
        self.tblDataUsage.reloadData()
    }
    
    func didGetMobileDataUsageWith(error: String) {
        self.showAlert(message: error, actionCompletion: {
            self.homeViewModel.fetchYearlyMobileDataUsage()
        })
    }
}

// MARK: - DataTableViewCellDelegate
extension HomeViewController: DataTableViewCellDelegate {
    func didTappedOnAttentionAt(indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
            
        if let yearRecord = homeViewModel.getYearRecordAt(index: indexPath.row) {
            let detailViewModel = DetailViewModel(yearRecord)
            vc.detailViewModel = detailViewModel
        }
            
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}
