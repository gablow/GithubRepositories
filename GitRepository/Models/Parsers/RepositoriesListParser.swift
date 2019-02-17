//
//  RepositoriesListParser.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 12/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import SwiftyJSON

class RepositoriesListParser: ParserProtocol {
    
    func parse(rawData: [String : AnyObject]) -> Any? {

        let rawJSON = JSON(rawData)

        let name = rawJSON["name"].string ?? ""
        let html_url = rawJSON["html_url"].string ?? ""
        let stars = rawJSON["stargazers_count"].number ?? 0
        let language = rawJSON["language"].string ?? ""
        let forks = rawJSON["forks_count"].number ?? 0
        let description = rawJSON["description"].string ?? ""
        
        return Repository(name: name, html_url: html_url, description: description, stars: stars, language: language, forks: forks)
    }
    
}
