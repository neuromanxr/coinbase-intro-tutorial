//
//  CoinbaseUser.swift
//  basic-coinbase-tutorial
//
//  Created by Kelvin Lee on 8/27/18.
//  Copyright © 2018 Kelvin Lee. All rights reserved.
//

class CoinbaseUser: Decodable {
    var id: String!
    var name: String!
    var userName: String? = nil
    var profileLocation: String? = nil
    var profileBio: String? = nil
    var profileUrl: String? = nil
    var avatarUrl: String!
    var resource: String!
    var resourcePath: String!
    
    enum CoinbaseUserKey: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case profileLocation = "profile_location"
        case profileBio = "profile_bio"
        case profileUrl = "profile_url"
        case avatarUrl = "avatar_url"
        case resource = "resource"
        case resourcePath = "resource_path"
    }
    
    init(id: String, name: String, userName: String?, profileLocation: String?, profileBio: String?, profileUrl: String?, avatarUrl: String, resource: String, resourcePath: String) {
        self.id = id
        self.name = name
        self.userName = userName
        self.profileLocation = profileLocation
        self.profileBio = profileBio
        self.profileUrl = profileUrl
        self.avatarUrl = avatarUrl
        self.resource = resource
        self.resourcePath = resourcePath
    }
    
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CoinbaseUserKey.self)
        
        let id: String = try values.decode(String.self, forKey: .id)
        let name: String = try values.decode(String.self, forKey: .name)
        var userName: String? = nil
        if let user: String = try values.decodeIfPresent(String.self, forKey: .username) {
            userName = user
        }
        var profileLocation: String? = nil
        if let location: String = try values.decodeIfPresent(String.self, forKey: .profileLocation) {
            profileLocation = location
        }
        var profileBio: String?
        if let bio: String = try values.decodeIfPresent(String.self, forKey: .profileBio) {
            profileBio = bio
        }
        var profileUrl: String?
        if let url: String = try values.decodeIfPresent(String.self, forKey: .profileUrl) {
            profileUrl = url
        }
        let avatarUrl: String = try values.decode(String.self, forKey: .avatarUrl)
        let resource: String = try values.decode(String.self, forKey: .resource)
        let resourcePath: String = try values.decode(String.self, forKey: .resourcePath)
        
        self.init(id: id, name: name, userName: userName, profileLocation: profileLocation, profileBio: profileBio, profileUrl: profileUrl, avatarUrl: avatarUrl, resource: resource, resourcePath: resourcePath)
    }
}
