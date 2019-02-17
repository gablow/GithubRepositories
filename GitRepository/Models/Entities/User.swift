//
//  User.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 12/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

/**
 A single repository
 */
struct User {
    let name: String!
    let reposNum: NSNumber!
    let login: String!

    /**
     Initialises a repository
     
     - Parameter name: The name of the user
     - Parameter reposNum: Number of public repositories
     
     - Returns: An instance of Repository
     */
    init(name: String, reposNum: NSNumber, login: String) {
        self.name = name
        self.reposNum = reposNum
        self.login = login
    }
}
