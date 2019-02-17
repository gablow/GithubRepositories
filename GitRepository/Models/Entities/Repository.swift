//
//  Repository.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 12/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

/**
 A single repository
 */
struct Repository: Equatable {
    let name: String!
    let html_url: String!
    let description: String!
    let stars: NSNumber!
    let language: String!
    let forks: NSNumber!
    var branches: NSNumber!
    var commits: NSNumber!
    var complete: Bool!

    /**
     Initialises a repository
     
     - Parameter name: The name of the repository
     - Parameter html_url: An NSURL of the repository page
     - Parameter description: The description
     - Parameter stars: The number of the stars
     - Parameter language: The programming language
     - Parameter forks: The number of the forks
     
     - Returns: An instance of Repository
     */
    init(name: String, html_url: String, description: String, stars: NSNumber, language:String, forks: NSNumber) {
        self.name = name
        self.html_url = html_url
        self.description = description
        self.stars = stars
        self.language = language
        self.forks = forks
        self.complete = false
    }
}

func ==(lhs: Repository, rhs: Repository) -> Bool {
    return lhs.name == rhs.name && lhs.html_url == rhs.html_url && lhs.description == rhs.description && lhs.stars == rhs.stars && lhs.language == rhs.language && lhs.forks == rhs.forks
}
