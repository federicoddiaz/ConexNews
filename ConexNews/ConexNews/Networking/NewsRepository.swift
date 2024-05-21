//
//  NewsRepository.swift
//  ConexNews
//
//  Created by Federico Díaz on 20/05/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
}

class NewsRepository {
    func fetchNews(completion: @escaping (Result<Posts, NetworkError>) -> Void) {
        
        guard let service_ulr = URL(string: JsonPlaceHolderRoutes(route: .news).url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: service_ulr) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let new_data = data else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let users = try JSONDecoder().decode(Posts.self, from: new_data)
                completion(.success(users))
            } catch {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }
}
