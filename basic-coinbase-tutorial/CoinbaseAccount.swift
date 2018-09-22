//
//  CoinbaseAccount.swift
//  basic-coinbase-tutorial
//
//  Created by Kelvin Lee on 8/29/18.
//  Copyright © 2018 Kelvin Lee. All rights reserved.
//

class CoinbaseAccount: Decodable {
    /*"id": "58542935-67b5-56e1-a3f9-42686e07fa40",
    "name": "My Vault",
    "primary": false,
    "type": "vault",
    "currency": "BTC",
    "balance": {
    "amount": "4.00000000",
    "currency": "BTC"
    },
    "created_at": "2015-01-31T20:49:02Z",
    "updated_at": "2015-01-31T20:49:02Z",
    "resource": "account",
    "resource_path": "/v2/accounts/58542935-67b5-56e1-a3f9-42686e07fa40",
    "ready": true*/
    var id: String!
    var name: String!
    var primary: Bool!
    var type: String!
    var currencyCode: String!
    var currencyName: String!
    var balance: [String: String]!
    var created_at: String!
    var updated_at: String!
    var resource: String!
    var resourcePath: String!
    
    enum CoinbaseAccountKey: String, CodingKey {
        case id = "id"
        case name = "name"
        case primary = "primary"
        case type = "type"
        case currency = "currency"
        case balance = "balance"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case resource = "resource"
        case resourcePath = "resource_path"
        case ready = "ready"
    }
    
    enum CoinbaseAccountCurrency: String, CodingKey {
        case code = "code"
        case name = "name"
    }
    
    init(id: String, name: String, primary: Bool, type: String, currencyCode: String, currencyName: String, balance: [String: String], created_at: String, updated_at: String, resource: String, resourcePath: String) {
        self.id = id
        self.name = name
        self.primary = primary
        self.type = type
        self.currencyCode = currencyCode
        self.currencyName = currencyName
        self.balance = balance
        self.created_at = created_at
        self.updated_at = updated_at
        self.resource = resource
        self.resourcePath = resourcePath
        
    }
    
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CoinbaseAccountKey.self)
        
        let id: String = try values.decode(String.self, forKey: .id)
        let name: String = try values.decode(String.self, forKey: .name)
        let primary: Bool = try values.decode(Bool.self, forKey: .primary)
        let type: String = try values.decode(String.self, forKey: .type)
        let currency = try values.nestedContainer(keyedBy: CoinbaseAccountCurrency.self, forKey: .currency)
        let currencyCode: String = try currency.decode(String.self, forKey: .code)
        let currencyName: String = try currency.decode(String.self, forKey: .name)
        let balance: [String: String] = try values.decode([String: String].self, forKey: .balance)
        let created_at: String = try values.decode(String.self, forKey: .created_at)
        let updated_at: String = try values.decode(String.self, forKey: .updated_at)
        let resource: String = try values.decode(String.self, forKey: .resource)
        let resourcePath: String = try values.decode(String.self, forKey: .resourcePath)
//        let ready: Bool = try values.decode(Bool.self, forKey: .ready)
        
        self.init(id: id, name: name, primary: primary, type: type, currencyCode: currencyCode, currencyName: currencyName, balance: balance, created_at: created_at, updated_at: updated_at, resource: resource, resourcePath: resourcePath)
    }
}
