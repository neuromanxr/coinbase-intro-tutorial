//
//  CoinbaseServices.swift
//  basic-coinbase-tutorial
//
//  Created by Kelvin Lee on 8/28/18.
//  Copyright © 2018 Kelvin Lee. All rights reserved.
//

import Moya

enum CoinbaseServices {
    case getUser
    case getAccount
}

extension CoinbaseServices: TargetType {
    static let baseURLPath = "https://api.coinbase.com"
    
    var baseURL: URL { return URL(string: CoinbaseServices.baseURLPath)! }
    var path: String {
        switch self {
        case .getUser:
            return "/v2/user"
        case .getAccount:
            return "/v2/accounts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        case .getAccount:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getUser: // Send no parameters
            return .requestPlain
        case .getAccount: // Send no parameters
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .getUser, .getAccount:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return [
            "Accept": "application/vnd.api+json",
            "Content-Type": "application/vnd.api+json"
        ]
    }
}

extension CoinbaseServices: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        switch self {
        case .getUser, .getAccount:
            return .none
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
