//
//  LoginViewControllerTests.swift
//  GitRepositoryTests
//
//  Created by Lorenzo Colaizzi on 17/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import XCTest
import SafariServices

@testable import GitRepository

class LoginViewControllerTests: XCTestCase, SFSafariViewControllerDelegate, LoginRequestProtocol {
    
    var viewController: LoginViewController!
    private var loginExpectation: XCTestExpectation!
    private var redirectExpectation: XCTestExpectation!
    var isLogged: Bool!
    
    override func setUp() {
        self.viewController = LoginViewController()
        
        // Create a window to show SafariVC
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self.viewController
        window.makeKeyAndVisible()
        
        _ = self.viewController.view
        isLogged = self.viewController.isLogged()
    }

    func testConnectivity() {
        var connected: Bool
        connected = Connectivity.isNotConnectedToInternet
        XCTAssertNotNil(connected)
    }
    
    func testAlert() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = (storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController)
        
        self.viewController.loadView()
        self.viewController.viewDidLoad()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self.viewController
        window.makeKeyAndVisible()
        
        self.viewController.showAlert(title: "Error", message: "Error test")
        let expectation = XCTestExpectation(description: "testExample")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testLoginIfNeeded() {
        self.loginExpectation = expectation(description: "Login")

        if (isLogged) {
            loginExpectation.fulfill()
        }
        else {
            self.viewController.sendRequest()
        }
        
        self.viewController.safariVC?.delegate = self
        
        wait(for: [loginExpectation], timeout: 100)
    }
    
    func testRedirectUriWithExpiredCode(){
        
        self.redirectExpectation = expectation(description: "Redirect")

        NotificationCenter.default.post(name: Notification.Name("kSafariViewControllerCloseNotification"), object: NSURL(string: "githubrepositories://?aParam=paramVal&code=4a87052379b96de12996"), userInfo: nil)
        
        self.viewController.delegate = self

        wait(for: [redirectExpectation], timeout: 100)
    }
    
    // MARK: delegates
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if (didLoadSuccessfully) {
            loginExpectation.fulfill()
        }
    }

    func onLoginSuccess() {
        XCTFail("The test fails if the login successful")
    }
    
    func onLoginFailure() {
        redirectExpectation.fulfill()
    }
    
}
