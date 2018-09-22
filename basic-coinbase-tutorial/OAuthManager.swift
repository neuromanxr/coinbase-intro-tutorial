//
//  OAuthManager.swift
//  basic-coinbase-tutorial
//
//  Created by Kelvin Lee on 9/2/18.
//  Copyright © 2018 Kelvin Lee. All rights reserved.
//

import UIKit
import p2_OAuth2

struct OAuthManager {
    static let shared = OAuthManager()
    
    var coinbaseOAuth2 = OAuth2CodeGrant(settings: [
        "client_id": "71c3d9f4b442798286da48fbfdf5d4b08952a4db712d7d75d55b518764f45cf7",
        "client_secret": "3ab52ab624716481680012ad15eaabb86a3c6bac8afe36c4756f1f225d776872",
        "authorize_uri": "https://www.coinbase.com/oauth/authorize",
        "token_uri": "https://api.coinbase.com/oauth/token",   // code grant only
        "redirect_uris": ["app://oauth-tutorial"],   // register your own "myapp" scheme in Info.plist
        "scope": "wallet:user:read,wallet:accounts:read,wallet:addresses:read,wallet:transactions:read",
        "secret_in_body": false,    // Github needs this
        "keychain": true,         // if you DON'T want keychain integration
        ] as OAuth2JSON)
}
