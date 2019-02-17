//
//  RepositoryCellViewTests.swift
//  GitRepositoryTests
//
//  Created by Lorenzo Colaizzi on 17/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import XCTest
@testable import GitRepository

class RepositoryCellViewTests: XCTestCase {

    var viewController: RepositoryViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = (storyboard.instantiateViewController(withIdentifier: "Repositories") as! RepositoryViewController)
        
        self.viewController.loadView()
        self.viewController.viewDidLoad()
        self.viewController.viewModel = RepositoryViewModel()
    }
    
}
