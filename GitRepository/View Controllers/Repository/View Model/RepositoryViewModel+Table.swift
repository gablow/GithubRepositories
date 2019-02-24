//
//  RepositoryViewModel+Table.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import UIKit

extension RepositoryViewModel {
    
    // MARK: UITableView
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesDataSource?.repositories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RepositoryCellView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCellIdentifier", for: indexPath) as! RepositoryCellView
        
        let repository = repositoriesDataSource!.repositories[indexPath.row] as Repository
        
        cell.titleLabel.text = repository.name
        cell.descriptionLabel.text = repository.description
        cell.starLabel.text = repository.stars.stringValue
        cell.forkLabel.text = repository.forks.stringValue
        
        if (repository.complete) {
            cell.branchLabel.text = repository.branches?.stringValue
            cell.commitsLabel.text = repository.commits?.stringValue
            cell.moreInfoButton.isHidden = true
            cell.branchView.isHidden = false
            cell.commitsView.isHidden = false
        }
        else {
            cell.moreInfoButton.isHidden = false
            cell.branchView.isHidden = true
            cell.commitsView.isHidden = true
        }
        
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            if (self.repositoriesDataSource!.canLoadMore) {
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
                
                if (!refreshing) {
                    self.fetchRepositories()
                }
            }
            else {
                print("⛔️ No more repositories.")
                tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
}
