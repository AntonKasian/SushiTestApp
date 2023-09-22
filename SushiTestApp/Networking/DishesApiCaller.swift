//
//  DishesApiCaller.swift
//  SushiTestApp
//
//  Created by Anton on 22.09.23.
//

import UIKit

class DishesApiCaller {
    private let baseURL = "https://vkus-sovet.ru/api"
    
    func getDishes(for menuID: String, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/getSubMenu.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Формируем параметры запроса
        let bodyString = "menuID=\(menuID)"
        request.httpBody = bodyString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MenuItemsResponse.self, from: data)
                let menuItems = response.menuList
                completion(.success(menuItems))
                
                print(data)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


