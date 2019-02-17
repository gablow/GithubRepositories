//
//  UserParser.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 12/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserParser: ParserProtocol {
    
    func parse(rawData: [String : AnyObject]) -> Any? {
        
        let rawJSON = JSON(rawData)
        
        let name = rawJSON["name"].string ?? ""
        let reposNum = rawJSON["public_repos"].number ?? 0
        let login = rawJSON["login"].string ?? ""

        return User(name: name, reposNum: reposNum, login: login)
    }
    
}
