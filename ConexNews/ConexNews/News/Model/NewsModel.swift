//
//  NewsModel.swift
//  ConexNews
//
//  Created by Federico Díaz on 19/05/2024.
//

import Foundation

struct Post: Codable {
    var id: Int?
    var slug: String?
    var url: String?
    var title: String?
    var content: String?
    var image: String?
    var thumbnail: String?
    var status: Status?
    var category: Category?
    var publishedAt: String?
    var updatedAt: String?
    var userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, slug, url, title, content, image, thumbnail, status, category, publishedAt, updatedAt
        case userID = "userId"
    }
}

enum Category: String, Codable {
    case elementum = "elementum"
    case ipsum = "ipsum"
    case jsonplaceholder = "jsonplaceholder"
    case lorem = "lorem"
    case rutrum = "rutrum"
}

enum Status: String, Codable {
    case published = "published"
}

typealias Posts = [Post]
