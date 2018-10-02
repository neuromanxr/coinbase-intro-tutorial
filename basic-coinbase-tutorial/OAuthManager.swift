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
        "client_id": "YOUR_CLIENT_ID",
        "client_secret": "YOUR_CLIENT_SECRET",
        "authorize_uri": "https://www.coinbase.com/oauth/authorize",
        "token_uri": "https://api.coinbase.com/oauth/token",   // code grant only
        "redirect_uris": ["app://oauth-tutorial"],   // register your own "myapp" scheme in Info.plist
        "scope": "wallet:user:read,wallet:accounts:read,wallet:addresses:read,wallet:transactions:read",
        "secret_in_body": false,
        "keychain": true,   // false, if you DON'T want keychain integration
        ] as OAuth2JSON)
}
