//
//  Model.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import Foundation

struct CategoryResponse: Codable {
    let status: Bool
    let menuList: [Category] // Обратите внимание, что menuList соответствует JSON-ключу
}

struct Category: Codable {
    let menuID: String
    let image: String
    let name: String
    let subMenuCount: Int
}
