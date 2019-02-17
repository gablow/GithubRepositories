//
//  RepositoriesParserTest.swift
//  GitRepositoryTests
//
//  Created by Lorenzo Colaizzi on 16/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import XCTest
@testable import GitRepository

class RepositoriesParserTest: XCTestCase {

    func testRepositoryFacebook() {
        let parser = RepositoriesListParser()
        var parsedArray = Array<Any?>()

        let expectedFirstRepository = Repository(
            name: "360-Capture-SDK",
            html_url: "https://github.com/facebook/360-Capture-SDK",
            description: "A developer focused sample SDK that allows game and virtual Reality devs to be able to easily and quickly integrate 360 photo/video capture capability into their game apps.",
            stars: 189,
            language: "C++",
            forks: 53)
        
        guard let response = self.jsonAtPath(pathName: "RepoFacebook") else {
            XCTFail("Failed to get JSON")
            return
        }
        
        for element in response {
            if let value = element as? [String : AnyObject] {
                let parsedModel = parser.parse(rawData: value)
                parsedArray.append(parsedModel)
            }
        }
        
        let repositories = parsedArray as! [Repository]
        
        XCTAssertEqual(repositories[0], expectedFirstRepository)
    }
    
    func testRepositoryApple() {
        let parser = RepositoriesListParser()
        var parsedArray = Array<Any?>()
        
        let expectedFirstRepository = Repository(
            name: "ccs-caldavclientlibrary",
            html_url: "https://github.com/apple/ccs-caldavclientlibrary",
            description: "CalDAV/CardDAV Testing Tool Used by CalendarServer",
            stars: 19,
            language: "HTML",
            forks: 10)
        
        guard let response = self.jsonAtPath(pathName: "RepoApple") else {
            XCTFail("Failed to get JSON")
            return
        }
        
        for element in response {
            if let value = element as? [String : AnyObject] {
                let parsedModel = parser.parse(rawData: value)
                parsedArray.append(parsedModel)
            }
        }
        
        let repositories = parsedArray as! [Repository]
        
        XCTAssertEqual(repositories[0], expectedFirstRepository)
    }
    
    func testRepositoryFacebookWithoutKeys() {
        let parser = RepositoriesListParser()
        var parsedArray = Array<Any?>()
        
        let expectedFirstRepository = Repository(
            name: "",
            html_url: "",
            description: "",
            stars: 0,
            language: "",
            forks: 0)
        
        guard let response = self.jsonAtPath(pathName: "RepoFacebookWithoutKeys") else {
            XCTFail("Failed to get JSON")
            return
        }
        
        for element in response {
            if let value = element as? [String : AnyObject] {
                let parsedModel = parser.parse(rawData: value)
                parsedArray.append(parsedModel)
            }
        }
        
        let repositories = parsedArray as! [Repository]
        
        XCTAssertEqual(repositories[0], expectedFirstRepository)
    }
    
    // MARK: Utility
    private func jsonAtPath(pathName: String) -> NSArray? {
        guard let path = Bundle(for: type(of: self)).path(forResource: pathName, ofType: "json") else {
            XCTFail("Unable to get JSON from bundle")
            return nil
        }
        
        guard let jsonData = NSData(contentsOfFile: path) else {
            XCTFail("Unable to create JSON data")
            return nil
        }
        
        var response: NSArray?
        do {
            response = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions()) as? NSArray
        } catch {
            XCTFail("Unable to parse JSON")
        }
        return response
    }
    
}
