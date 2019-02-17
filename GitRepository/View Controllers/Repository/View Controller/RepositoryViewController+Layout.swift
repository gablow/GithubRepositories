//
//  RepositoryViewController+Layout.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import UIKit

extension RepositoryViewController {
    
    func loadActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.view.center
        self.view.addSubview(activityView!)
    }
    
    func loadSearchBar() {
        if #available(iOS 11.0, *) {
            navigationItem.searchController = UISearchController(searchResultsController: nil)
            navigationItem.searchController!.searchBar.placeholder = "Search GitHub user repositories..."
            navigationItem.searchController?.searchBar.delegate = self
        } else {
            let searchBar = UISearchController(searchResultsController: nil)
                .searchBar
            searchBar.placeholder = "Search GitHub user repositories..."
            searchBar.delegate = self
            tableView.tableHeaderView = searchBar
            self.extendedLayoutIncludesOpaqueBars = true;
        }
        self.definesPresentationContext = true
    }
}
