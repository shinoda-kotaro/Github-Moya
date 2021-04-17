//
//  Repository.swift
//  GithubAPI
//
//  Created by 信田　虎太郎 on 2021/04/17.
//

import Foundation

struct Repositories: Codable {
    var items: [Repository]
}

struct Repository: Codable {
    var name: String?
    var url: String?
    var htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case htmlUrl = "html_url"
    }
}
