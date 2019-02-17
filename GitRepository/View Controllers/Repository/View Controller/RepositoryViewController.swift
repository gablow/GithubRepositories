//
//  RepositoryViewController.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, RepositoryViewModelDelegate, LoadMoreInfoButtonDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: RepositoryViewModel!
    var activityView: UIActivityIndicatorView!
    
    // MARK: Override

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()

        // TODO: prerequisite check

        viewModel = RepositoryViewModel()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            tableView.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    // MARK: Setup
    
    func setupViews() {
        loadActivityIndicator()
        loadSearchBar()
        setNavigationBarStyle()
    }
    
    // MARK: RepositoryViewModelDelegates
    
    func onUpdateUserInfo(userName: String) {
        self.startToFetchRepositories()
        self.navigationItem.title = userName
    }
    
    func onUpdateErrorUserInfo(error: NSError) {
        self.showAlert(title:"Alert", message:"The user may not exist")
        self.hideSpinner()
        self.navigationItem.title = ""
    }
    
    func onUpdateRepository() {
        self.hideSpinner()
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func onUpdateErrorRepository(error: NSError) {
        self.showAlert(title:"Alert", message:"Generic error with repository")
        self.hideSpinner()
    }
    
    func onUpdateCell(indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func onUpdateErrorCell(error: NSError) {
        self.showAlert(title:"Alert", message:"Generic error with the request")
    }
    
    // MARK: More Info Button delegate
    
    func loadMoreInfo(at index: IndexPath) {
        viewModel.fetchMoreInfo(index: index)
    }
    
    // MARK: Searchbar delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSpinner()
        
        if Connectivity.isNotConnectedToInternet {
            self.showAlert(title: "Alert", message: "It seems that you are offline. Please check your internet connection.")
            return
        }
        
        self.fetchUserInfo(userName: searchBar.text ??  "")
        
        searchBar.text = ""
        self.tableView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    func fetchUserInfo(userName: String) {
        viewModel.fetchUserInfo(user: userName)
    }
    
    func startToFetchRepositories() {
        viewModel.fetchRepositories()
    }
    
    // MARK: Helper
    
    func showSpinner() {
        activityView.startAnimating()
    }
    
    func hideSpinner() {
        activityView.stopAnimating()
    }
    
}
