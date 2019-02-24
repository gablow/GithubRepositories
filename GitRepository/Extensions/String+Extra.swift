//
//  String+Extra.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 22/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
