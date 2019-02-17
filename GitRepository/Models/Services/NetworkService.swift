//
//  NetworkService.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService: NSObject {

    // MARK: - Alamofire
    internal func makeGETRequestToEndpoint(endpoint: NSURL, withParser parser: ParserProtocol, withCompletion completion:@escaping (_ parsedModel: Any?, _ header: String?, _ error: NSError?) -> Void) {
    
        let endpointConvertible = URLRequest(url:endpoint as URL)
        
        Alamofire.request(endpointConvertible).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("🎉 Recieved response from \(endpoint.absoluteString!)")
                
                if let value = response.result.value as? [String : AnyObject] {
                    DispatchQueue.global(qos: .background).async {
                        let parsedModel = parser.parse(rawData: value)
                        DispatchQueue.main.async(execute: {
                            completion(parsedModel, "", nil)
                        })
                    }
                }
                else if let objJson = response.result.value as? NSArray {
                    var parsedArray = Array<Any?>()
                    let linkHeader = response.response?.allHeaderFields["Link"] as? String
                    
                    for element in objJson {
                        if let value = element as? [String : AnyObject] {
                            let parsedModel = parser.parse(rawData: value)
                            parsedArray.append(parsedModel)
                        }
                    }
                    DispatchQueue.main.async(execute: {
                        completion(parsedArray, linkHeader, nil)
                    })
                }
                
            case .failure(let error):
                print("⚠️ Failed to make request to \(endpoint)\nError: \(error.localizedDescription)")
                DispatchQueue.main.async(execute: {
                    completion(nil, "", error as NSError)
                })
            }
        }
    }
}
