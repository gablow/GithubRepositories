//
//  RepositoryViewModel+Network.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 13/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

extension RepositoryViewModel {
    
    func networkRequest(endpoint: NSURL, parser: ParserProtocol, completion: @escaping (_ parsedModel: Any?, _ linkHeader: String?, _ error: NSError?) -> Void) {        
        networkService.makeGETRequestToEndpoint(endpoint: endpoint, withParser: parser, withCompletion: completion)
    }
    
}
