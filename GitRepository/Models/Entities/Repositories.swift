//
//  Repository.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 12/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

/**
 Repositories DataSource
 */
struct Repositories {
    var repositories: [Repository]
    var pageNumber: NSNumber
    let repositoriesNumber: NSNumber
    var canLoadMore: Bool {
        get {
            return repositoriesNumber.intValue > repositories.count
        }
    }
    
    /**
     Initialises a repository
     
     - Parameter repositories: Datasource repositories
     - Parameter pageNumber: Page number of request
     - Parameter repositoriesNumber: Total number of repositories

     - Returns: An instance of Repositories
     */
    init(repositoriesNumber: NSNumber) {
        self.repositories = [Repository]()
        self.pageNumber = 0
        self.repositoriesNumber = repositoriesNumber
    }
}
