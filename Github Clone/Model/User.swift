//
//  User.swift
//  Github Clone
//
//  Created by Umar Akram on 24/03/2025.
//

import Foundation

struct User: Codable{
    var login: String
    var avatarUrl:String
    var name: String?
    var locatio: String?
    var bio: String?
    var publicRepos: Int
    var publicGist: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
    
}
