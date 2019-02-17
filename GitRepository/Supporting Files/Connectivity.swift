//
//  Connectivity.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 17/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isNotConnectedToInternet:Bool {
        return !NetworkReachabilityManager()!.isReachable
    }
}
