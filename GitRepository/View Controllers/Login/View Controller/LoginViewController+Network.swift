//
//  LoginViewController+Network.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 17/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import Alamofire

protocol LoginRequestProtocol: class {
    func onLoginSuccess()
    func onLoginFailure()
}

extension LoginViewController {
    
    func makeRequest(token_uri: String, parameters: [String : Any]) {
        Alamofire.request(token_uri, method: .post, parameters: parameters).responseString { response in
            // TODO: handle error
            if let result = response.result.value, let makeItUrl = NSURL(string: "https://api.github.com/?\(result)") {
                if let access_code = self.getParameterFrom(url: String(describing: makeItUrl), param: "access_token") {
                    UserDefaults.standard.set(access_code, forKey: "Token")
                    self.delegate?.onLoginSuccess()
                    self.performSegue(withIdentifier: "toRepositories", sender: nil)
                }
                else {
                    self.delegate?.onLoginFailure()
                }
            }
            else {
                self.delegate?.onLoginFailure()
            }
            
        }
    }
    
    // MARK: Helper
    
    func getParameterFrom(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
}
