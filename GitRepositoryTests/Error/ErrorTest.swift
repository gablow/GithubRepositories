//
//  ErrorTest.swift
//  GitRepositoryTests
//
//  Created by Lorenzo Colaizzi on 23/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import XCTest
@testable import GitRepository

class ErrorTest: XCTestCase {

    func testGenericError() {
        let expectedGenericErrorString = LocalizedString.errorGeneric
        
        let result = GitError.getNetworkErrorType(statusCode: 500, callerErrorType: GitError.moreInfoError)
        
        XCTAssertEqual(result.errorDescription, expectedGenericErrorString)
    }
    
    func testRateLimitsError() {
        let expectedRateLimitsErrorString = LocalizedString.errorRateLimits
        
        let result = GitError.getNetworkErrorType(statusCode: 403, callerErrorType: GitError.moreInfoError)
        
        XCTAssertEqual(result.errorDescription, expectedRateLimitsErrorString)
    }
    
    func testUserNotFoundError() {
        let expectedUserNotFoundErrorString = LocalizedString.errorUserNotExists
        
        let result = GitError.getNetworkErrorType(statusCode: 404, callerErrorType: GitError.userNotFoundError)
        
        XCTAssertEqual(result.errorDescription, expectedUserNotFoundErrorString)
    }

}
