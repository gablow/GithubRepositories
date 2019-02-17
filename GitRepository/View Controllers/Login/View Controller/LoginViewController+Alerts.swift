//
//  LoginViewController+Alerts.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 17/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok",
                                    style: .default,
                                    handler: nil)
        
        alertController.addAction(dismiss)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
