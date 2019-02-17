//
//  RepositoryViewController+Style.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import UIKit

extension RepositoryViewController {
    
    func setNavigationBarStyle() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.NavigationBarColor()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = true
        self.navigationItem.hidesBackButton = true
    }

}
