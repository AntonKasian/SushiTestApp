//
//  Model.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import Foundation

struct CategoryResponse: Codable {
    let status: Bool
    var menuList: [Category] 
}

struct Category: Codable {
    let menuID: String
    var image: String
    let name: String
    let subMenuCount: Int
}
