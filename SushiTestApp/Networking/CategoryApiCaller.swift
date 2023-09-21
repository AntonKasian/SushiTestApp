//
//  CategoryApiCaller.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import Foundation

class CategoryApiCaller {
    private let baseURL = "https://vkus-sovet.ru/api"
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/getMenu.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                let response = try decoder.decode(CategoryResponse.self, from: data)
                let categories = response.menuList
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}





