//
//  ViewController.swift
//  basic-coinbase-tutorial
//
//  Created by Kelvin Lee on 8/20/18.
//  Copyright © 2018 Kelvin Lee. All rights reserved.
//

import UIKit
import Alamofire
import p2_OAuth2
import Moya

class ViewController: UIViewController {

    @IBOutlet weak var loginCoinbaseButton: UIButton!
    @IBAction func loginCoinbaseButtonAction(_ sender: UIButton) {
        authorizeCoinbase()
    }
    @IBOutlet weak var sendRequestButton: UIButton!
    @IBAction func sendRequestButtonAction(_ sender: UIButton) {
        getUser()
    }
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var getAccountButton: UIButton!
    @IBAction func getAccountButtonAction(_ sender: UIButton) {
        getAccount()
    }
    @IBOutlet weak var accountLabel: UILabel!
    @IBAction func logout(_ sender: UIButton) {
        oauth2.forgetTokens()
    }
    
    var sessionManager: SessionManager!
    var oauth2: OAuth2CodeGrant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        oauth2 = OAuthManager.shared.coinbaseOAuth2
        sessionManager = SessionManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAccount() {
//        self.authorizeCoinbase()
        
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        sessionManager.adapter = retrier
        sessionManager.retrier = retrier
        
        let provider = MoyaProvider<CoinbaseServices>(manager: sessionManager)
        provider.request(.getAccount) { (result) in
            debugPrint("get coinbase account:\(result.value?.data)")
            switch result {
            case let .success(response):
                do {
//                    let json = try JSONSerialization.jsonObject(with: result.value!.data, options: []) as? [String : Any]
//                    debugPrint("Coinbase account json:\(json)")
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let account = try filteredResponse.map([CoinbaseAccount].self, atKeyPath: "data", using: decoder, failsOnEmptyData: false)
                    debugPrint("Coinbase account:\(account.first?.balance)")
                    self.accountLabel.text = account.first?.balance["amount"]
                }
                catch let error {
                    debugPrint("Coinbase account error:\(error)")
                }
            case let .failure(error):
                debugPrint("Coinbase account failure error:\(error)")
                break
            }
        }
        oauth2.logger = OAuth2DebugLogger(.trace)
    }
    
    private func getUser() {
//        self.authorizeCoinbase()
        
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        sessionManager.adapter = retrier
        sessionManager.retrier = retrier
        
        let provider = MoyaProvider<CoinbaseServices>(manager: sessionManager)
        provider.request(.getUser) { (result) in
            debugPrint("get coinbase user:\(result)")
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let user = try filteredResponse.map(CoinbaseUser.self, atKeyPath: "data", using: decoder, failsOnEmptyData: false)
                    debugPrint("Coinbase user:\(user.name)")
                    self.userLabel.text = user.name
                }
                catch let error {
                    debugPrint("Coinbase user error:\(error)")
                }
            case let .failure(error):
                debugPrint("Coinbase user failure error:\(error)")
                break
            }
        }
        oauth2.logger = OAuth2DebugLogger(.trace)
    }
    
    private func authorizeCoinbase() {
        oauth2.authConfig.authorizeEmbedded = true
        oauth2.authConfig.authorizeContext = self
        oauth2.authorize(params: nil) { (json, error) in
            debugPrint("auth: json:\(json). error: \(String(describing: error))")
        }
        oauth2.logger = OAuth2DebugLogger(.trace)
    }
}

