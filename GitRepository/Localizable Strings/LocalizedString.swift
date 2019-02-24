//
//  LocalizedString.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 23/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

/// - Tag: LocalizedString

struct LocalizedString {

    // Generic
    
    static let searchUser = "search_user".localized
    static let emptyRepositories = "repositories_empty".localized

    // Alerts
    
    static let alertTitle = "alert_title".localized
    static let okButton = "ok".localized

    // Errors
    
    static let errorUserNotExists = "error_user_not_exists".localized
    static let errorFetchRepository = "error_fetch_repository".localized
    static let errorFetchMoreInfo = "error_fetch_more_info".localized
    static let errorRateLimits = "error_rate_limits".localized
    static let errorDisconnected = "error_disconnected".localized
    static let errorGeneric = "error_generic".localized
    
}
