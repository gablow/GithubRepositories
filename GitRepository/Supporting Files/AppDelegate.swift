//
//  AppDelegate.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 10/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        if ("githubrepositories" == url.scheme) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kSafariViewControllerCloseNotification), object: url)
                return true
        }
        
        return false
    }
    
}

