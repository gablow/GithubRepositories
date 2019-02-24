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
        loadNavigationBar()
    }
    
    // MARK: RepositoryViewModelDelegates
    
    func onUpdateUserInfo(userName: String, continueWithFetch: Bool) {
        self.navigationItem.title = userName

        if (continueWithFetch) {
            viewModel.fetchRepositories()
        }
        else {
            self.showAlert(title: LocalizedString.alertTitle, message: LocalizedString.emptyRepositories)
            self.hideSpinner()
        }
    }
    
    func onUpdateErrorUserInfo(error: NSError) {
        self.showAlert(title: LocalizedString.alertTitle, message: error.localizedDescription)
        self.hideSpinner()
        self.navigationItem.title = ""
    }
    
    func onUpdateRepository() {
        self.hideSpinner()
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func onUpdateErrorRepository(error: NSError) {
        self.showAlert(title:LocalizedString.alertTitle, message:error.localizedDescription)
        self.hideSpinner()
    }
    
    func onUpdateCell(indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func onUpdateErrorCell(error: NSError, indexPath: IndexPath) {
        self.showAlert(title:LocalizedString.alertTitle, message:error.localizedDescription)
        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    // MARK: More Info Button delegate
    
    func loadMoreInfo(at index: IndexPath) {
        viewModel.fetchMoreInfo(index: index)
    }
    
    // MARK: Searchbar delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSpinner()
        
        if Connectivity.isNotConnectedToInternet {
            self.showAlert(title: LocalizedString.alertTitle, message: LocalizedString.errorDisconnected)
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
    
    // MARK: Helper
    
    func showSpinner() {
        activityView.startAnimating()
    }
    
    func hideSpinner() {
        activityView.stopAnimating()
    }
    
}
