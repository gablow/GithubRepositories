//
//  RepositoryTableViewTests.swift
//  GitRepositoryTests
//
//  Created by Lorenzo Colaizzi on 17/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import XCTest
@testable import GitRepository

class RepositoryTableViewTests: XCTestCase, RepositoryViewModelDelegate, LoadMoreInfoButtonDelegate {
    
    var viewController: RepositoryViewController!
    var isIdentifier: Bool!
    private var cellExpectation: XCTestExpectation!
    private var canLoadMoreExpectation: XCTestExpectation!
    private var textExpectation: XCTestExpectation!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = (storyboard.instantiateViewController(withIdentifier: "Repositories") as! RepositoryViewController)
        
        self.viewController.loadView()
        self.viewController.viewDidLoad()
        self.viewController.viewModel = RepositoryViewModel()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewController.tableView)
    }

    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
    }
    
    func testTableViewCell() {
        self.cellExpectation = expectation(description: "Table identifier test")
        self.canLoadMoreExpectation = expectation(description: "Can load more test")
        self.viewController.viewModel.delegate = self
        self.viewController.viewModel.delegate = self
        self.viewController.fetchUserInfo(userName: "Facebook")
        wait(for: [cellExpectation], timeout: 100)
        wait(for: [canLoadMoreExpectation], timeout: 100)
    }
    
    // Delegates
    
    func onUpdateUserInfo(userName: String, continueWithFetch: Bool) {
        if (continueWithFetch) {
            self.viewController.viewModel.fetchRepositories()
        }
    }
    
    func onUpdateErrorUserInfo(error: NSError) {
        
    }
    
    func onUpdateRepository() {
        // Has the same identifier
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RepositoryCellView
        
        cell!.delegate = self

        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "RepositoryCellIdentifier"
        let expectedCanLoadMore = true
        
        // Has the expected title (first and last cell test)
        let firstCell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RepositoryCellView
        
        let lastCell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: (viewController.viewModel.repositoriesDataSource?.repositories.count)! - 1, section: 0)) as? RepositoryCellView
        
        let isSameIdentifier = expectedReuseIdentifier == actualReuseIdentifer
        let isSameTextFirstCell = firstCell?.titleLabel.text == "360-Capture-SDK"
        let isSameTextLastCell = lastCell?.titleLabel.text == "facebook-instant-articles-sdk-php"

        if (viewController.viewModel.repositoriesDataSource!.canLoadMore == expectedCanLoadMore) {
            canLoadMoreExpectation.fulfill()
        }
        else {
            XCTFail("Error in can load more test")
        }
        
        if (isSameIdentifier && isSameTextFirstCell && isSameTextLastCell) {
            cell?.moreInfoButton.sendActions(for: .touchUpInside)
        }
        else {
            XCTFail("Error in cell test")
        }
    }
    
    func onUpdateErrorRepository(error: NSError) {
        
    }
    
    func onUpdateCell(indexPath: IndexPath) {
        
    }
    
    func onUpdateErrorCell(error: NSError, indexPath: IndexPath) {
        
    }
    
    func loadMoreInfo(at index: IndexPath) {
        cellExpectation.fulfill()
    }
    
}
