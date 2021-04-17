//
//  User.swift
//  GithubAPI
//
//  Created by 信田　虎太郎 on 2021/04/17.
//

import Foundation

struct User: Codable {
    var id: Int?
    var url: String
    var login: String
    var email: String?
}
