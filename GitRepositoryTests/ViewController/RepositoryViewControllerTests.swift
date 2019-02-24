//
//  RepositoryViewModelTests.swift
//  GitRepositoryTests
//
//  Created by Lorenzo Colaizzi on 16/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import XCTest
@testable import GitRepository

class RepositoryViewControllerTests: XCTestCase, RepositoryViewModelDelegate {
    
    private var nameReturned: String!
    var viewController: RepositoryViewController!
    private var nameExpectation: XCTestExpectation!
    private var nameErrorExpectation: XCTestExpectation!
    private var repoExpectation: XCTestExpectation!
    private var repoEmptyExpectation: XCTestExpectation!
    private var moreinfoExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        self.viewController = RepositoryViewController()
        self.viewController.viewModel = RepositoryViewModel()
        
        // Trigger viewDidLoad()
        _ = self.viewController.view
    }
    
    // MARK: Setup
    
    func testSearchBar() {
        self.viewController.loadSearchBar()
        var placeholder: String?
        let expectedPlaceholder = "search_user".localized

        if #available(iOS 11.0, *) {
            placeholder = self.viewController.navigationItem.searchController!.searchBar.placeholder
        } else {
            // TODO:
        }
        
        XCTAssertEqual(placeholder, expectedPlaceholder)
    }
    
    func testNavigationBarStyle() {
        let navigation = UINavigationController()
        navigation.viewControllers = [self.viewController]
        self.viewController.loadNavigationBar()
        let color = self.viewController.navigationController?.navigationBar.tintColor
        let expectedColor = UIColor.NavigationBarColor()
        
        XCTAssertEqual(color, expectedColor)
    }
    
    func testShowSpinner() {
        self.viewController.showSpinner()
        XCTAssertTrue(self.viewController.activityView.isAnimating)
    }
    
    func testHideSpinner() {
        self.viewController.hideSpinner()
        XCTAssertTrue(!self.viewController.activityView.isAnimating)
    }
    
    func testAlert() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = (storyboard.instantiateViewController(withIdentifier: "Repositories") as! RepositoryViewController)
        
        self.viewController.loadView()
        self.viewController.viewDidLoad()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self.viewController
        window.makeKeyAndVisible()
        
        self.viewController.showAlert(title: "Error", message: "Error test")
        let expectation = XCTestExpectation(description: "testExample")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testConnectivity() {
        var connected: Bool
        connected = Connectivity.isNotConnectedToInternet
        XCTAssertNotNil(connected)
    }
    
    // MARK: Fetch user and repositories
    
    func testFetchUserInfo() {
        let user = "facebook"
        self.nameExpectation = expectation(description: "Fetch user info")
        self.repoExpectation = expectation(description: "Fetch repositories")
        self.moreinfoExpectation = expectation(description: "Fetch more info")

        self.viewController.viewModel.delegate = self
        self.viewController.fetchUserInfo(userName: user)
        
        wait(for: [nameExpectation], timeout: 100)
        wait(for: [repoExpectation], timeout: 100)
        wait(for: [moreinfoExpectation], timeout: 100)
        
        // TODO:
        XCTAssertEqual(self.nameReturned, "Facebook")
    }
    
    func testFetchUserInfoDoesNotExists() {
        let user = "facebookkkkkkk"
        self.nameErrorExpectation = expectation(description: "Fetch user info")
        
        self.viewController.viewModel.delegate = self
        self.viewController.fetchUserInfo(userName: user)
        
        wait(for: [nameErrorExpectation], timeout: 100)
    }
    
    func testFetchUserWithNoRepositories() {
        let user = "facebookkkk"
        self.repoEmptyExpectation = expectation(description: "Fetch user with no repositories")
        
        self.viewController.viewModel.delegate = self
        self.viewController.fetchUserInfo(userName: user)
        
        wait(for: [repoEmptyExpectation], timeout: 100)
    }
    
    // MARK: Delegates
    
    func onUpdateUserInfo(userName: String, continueWithFetch: Bool) {
        print("onUpdateUserInfo")
        self.nameReturned = userName
        
        if (continueWithFetch) {
            nameExpectation.fulfill()
            self.viewController.viewModel.fetchRepositories()
        }
        else {
            repoEmptyExpectation.fulfill()
        }
    }
    
    func onUpdateErrorUserInfo(error: NSError) {
        print("onUpdateErrorUserInfo")
        nameErrorExpectation.fulfill()
    }
    
    func onUpdateRepository() {
        print("onUpdateRepository")
        repoExpectation.fulfill()
        self.viewController.viewModel.fetchMoreInfo(index: IndexPath(row: 0, section: 0))
    }
    
    func onUpdateErrorRepository(error: NSError) {
        XCTFail("Failed to update repository")
    }
    
    func onUpdateCell(indexPath: IndexPath) {
        print("onUpdateCell")
        moreinfoExpectation.fulfill()
    }
    
    func onUpdateErrorCell(error: NSError, indexPath: IndexPath) {
        XCTFail("Failed to update cell")
    }
    
}
