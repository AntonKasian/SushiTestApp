//
//  CategoryApiCaller.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

final class CategoryApiCaller {
    static let shared = CategoryApiCaller()
    
    struct Constant {
        static let categoryAPIURL = URL(string: "https://vkus-sovet.ru/api/getMenu.php")
    }
    
    private init() {}
    
    public func getCategories(completion: @escaping (Result<CategoryResponse, Error>) -> Void) { // Измените тип результата на CategoryResponse
        guard let url = Constant.categoryAPIURL else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let response = try JSONDecoder().decode(CategoryResponse.self, from: data) // Декодируйте CategoryResponse
                        completion(.success(response))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

