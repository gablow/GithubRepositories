//
//  LoginViewController.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 13/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import UIKit
import SafariServices
import Alamofire

let kSafariViewControllerCloseNotification = "kSafariViewControllerCloseNotification"

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var loginButton: UIButton!
    
    var safariVC: SFSafariViewController?
    weak var delegate: LoginRequestProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(safariLogin(notification:)), name: NSNotification.Name(rawValue: kSafariViewControllerCloseNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: IBAction
    
    @IBAction func loginRequest(_ sender: Any) {
        let isLogged = self.isLogged()
        
        if (isLogged) {
            self.performSegue(withIdentifier: "toRepositories", sender: nil)
        }
        else {
            self.sendRequest()
        }
    }
    
    // MARK: Methods
    
    func isLogged() -> Bool {
        return (UserDefaults.standard.string(forKey: "Token")) != nil
    }
    
    func sendRequest() {
        let client_id = Services.valueForServiceKey(key: .OauthClientId)!
        let scope = Services.valueForServiceKey(key: .OauthScope)!
        let auth_url = Services.valueForServiceKey(key: .GitHubAuthorize)!
        
        if Connectivity.isNotConnectedToInternet {
            self.showAlert(title: "Alert", message: "It seems that you are offline. Please check your internet connection.")
            return
        }
        
        if let stringUrl = "\(auth_url)?scope=\(scope)&client_id=\(client_id)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed), let url = URL(string: stringUrl) {
            
            safariVC = SFSafariViewController(url: url)
            safariVC!.delegate = self
            
            self.present(safariVC!, animated: true, completion: nil)
        }
    }
    
    // MARK: Notification
    
    @objc func safariLogin(notification: NSNotification) {
        
        let url = notification.object as! NSURL
        
        let code = self.getParameterFrom(url: String(describing: url), param: "code")
        
        let client_id = Services.valueForServiceKey(key: .OauthClientId)!
        let client_secret = Services.valueForServiceKey(key: .OauthSecret)!
        let token_uri = Services.valueForServiceKey(key: .OauthTokernUri)!

        let parameters = ["client_id": client_id, "client_secret": client_secret, "code": code!, "accept": "application/json"] as [String : Any]
        
        self.makeRequest(token_uri: token_uri, parameters: parameters)
        
        if (self.safariVC != nil) {
            self.safariVC?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: SafariViewController delegates
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {        
        controller.dismiss(animated: true)
    }
    
}
