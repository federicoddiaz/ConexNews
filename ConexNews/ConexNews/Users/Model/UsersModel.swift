//
//  UsersModel.swift
//  ConexNews
//
//  Created by Federico Díaz on 19/05/2024.
//

import Foundation

struct User: Codable {
    var id: Int?
    var firstname: String?
    var lastname: String?
    var email: String?
    var birthDate: String?
    var login: Login?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
}

struct Address: Codable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
}

struct Geo: Codable {
    var lat: String?
    var lng: String?
}

struct Company: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

struct Login: Codable {
    var uuid: String?
    var username: String?
    var password: String?
    var md5: String?
    var sha1: String?
    var registered: String?
}

typealias Users = [User]
