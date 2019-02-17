//
//  UsersParserTest.swift
//  GitRepositoryTests
//
//  Created by Lorenzo Colaizzi on 16/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import XCTest
@testable import GitRepository

class UsersParserTest: XCTestCase {

    func testUserFacebook() {
        let parser = UserParser()
        
        let expectedUserName = "Facebook"
        let expectedUserRepoNum = 160 as NSNumber
        let expectedUserLogin = "facebook"
        
        guard let response = self.jsonAtPath(pathName: "UserFacebook") else {
            XCTFail("Failed to get JSON")
            return
        }
        
        let parsedUser = parser.parse(rawData: response) as! User
        let expectedUser = User(name: expectedUserName, reposNum: expectedUserRepoNum, login: expectedUserLogin)
        
        XCTAssertEqual(parsedUser.name, expectedUser.name)
        XCTAssertEqual(parsedUser.reposNum, expectedUser.reposNum)
        XCTAssertEqual(parsedUser.login, expectedUser.login)
    }
    
    func testUserApple() {
        let parser = UserParser()
        
        let expectedUserName = "Apple"
        let expectedUserRepoNum = 59 as NSNumber
        let expectedUserLogin = "apple"
        
        guard let response = self.jsonAtPath(pathName: "UserApple") else {
            XCTFail("Failed to get JSON")
            return
        }
        
        let parsedUser = parser.parse(rawData: response) as! User
        let expectedUser = User(name: expectedUserName, reposNum: expectedUserRepoNum, login: expectedUserLogin)
        
        XCTAssertEqual(parsedUser.name, expectedUser.name)
        XCTAssertEqual(parsedUser.reposNum, expectedUser.reposNum)
        XCTAssertEqual(parsedUser.login, expectedUser.login)
    }
    
    func testEmptyUser() {
        let parser = UserParser()
        
        let expectedUserName = ""
        let expectedUserRepoNum = 0 as NSNumber
        let expectedUserLogin = ""
        
        guard let response = self.jsonAtPath(pathName: "UserAppleWithoutKeys") else {
            XCTFail("Failed to get JSON")
            return
        }
        
        let parsedUser = parser.parse(rawData: response) as! User
        let expectedUser = User(name: expectedUserName, reposNum: expectedUserRepoNum, login: expectedUserLogin)
        
        XCTAssertEqual(parsedUser.name, expectedUser.name)
        XCTAssertEqual(parsedUser.reposNum, expectedUser.reposNum)
        XCTAssertEqual(parsedUser.login, expectedUser.login)
    }
    
    // MARK: Utility
    private func jsonAtPath(pathName: String) -> [String : AnyObject]? {
        guard let path = Bundle(for: type(of: self)).path(forResource: pathName, ofType: "json") else {
            XCTFail("Unable to get JSON from bundle")
            return nil
        }
        
        guard let jsonData = NSData(contentsOfFile: path) else {
            XCTFail("Unable to create JSON data")
            return nil
        }
        
        var response: [String : AnyObject]?
        do {
            response = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions()) as? [String : AnyObject]
        } catch {
            XCTFail("Unable to parse JSON")
        }
        return response
    }

}
