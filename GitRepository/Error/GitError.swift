//
//  GitError.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 23/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation

public enum GitError: Error {
    case userNotFoundError
    case genericRepositoriesError
    case connectivityError
    case moreInfoError
    case rateLimitsError
    case genericError
}

extension GitError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNotFoundError:
            return LocalizedString.errorUserNotExists
            
        case .genericRepositoriesError:
            return LocalizedString.errorFetchRepository
            
        case .connectivityError:
            return LocalizedString.errorDisconnected
            
        case .moreInfoError:
            return LocalizedString.errorFetchMoreInfo
            
        case .rateLimitsError:
            return LocalizedString.errorRateLimits
            
        default:
            return LocalizedString.errorGeneric
        }
    }
    
    static func getNetworkErrorType(statusCode: Int, callerErrorType: GitError) -> GitError {
        switch statusCode {
        case 403:
            return GitError.rateLimitsError
            
        case 404:
            return callerErrorType
            
        default:
            return GitError.genericError
        }
    }
    
}
