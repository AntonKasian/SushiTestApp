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

struct MenuItemsResponse: Codable {
    let status: Bool
    var menuList: [MenuItem]
}



struct Category: Codable {
    let menuID: String
    var image: String
    let name: String
    let subMenuCount: Int
    let spicy: String?
}

struct MenuItem: Codable {
    let id: String
    let image: String
    let name: String
    let content: String
    let price: String
    let weight: String
    // Добавляем новое свойство spicy
    let spicy: String?
}



