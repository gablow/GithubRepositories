//
//  Services.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

enum ServiceKey: String {
    // URLs
    case GitHubAuthorize = "GITHUB_AUTHORIZE_URL"
    case GitHubReposUrl  = "GITHUB_BASE_URL_REPOS"
    case GitHubUsersUrl  = "GITHUB_BASE_URL_USERS"
    case OauthClientId   = "OAUTH_CLIENT_ID"
    case OAuthRedirect   = "OAUTH_REDIRECT_URI"
    case OauthSecret     = "OAUTH_SECRET"
    case OauthScope      = "OAUTH_SCOPE"
    case OauthTokernUri  = "OAUTH_TOKEN_URI"
}

class Services {
    class func valueForServiceKey(key: ServiceKey) -> String? {
        if let plistPath = Bundle.main.path(forResource: "ServiceEndpoints", ofType: "plist") {
            if let plistDictionary = NSDictionary.init(contentsOfFile: plistPath) {
                return plistDictionary[key.rawValue] as? String
            }
        }
        return nil
    }
}
