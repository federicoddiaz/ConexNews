//
//  UsersRepository.swift
//  ConexNews
//
//  Created by Federico Díaz on 21/05/2024.
//

import Foundation

class UsersRepository {
    func fetchUsers(completion: @escaping (Result<Users, NetworkError>) -> Void) {
        
        guard let service_ulr = URL(string: JsonPlaceHolderRoutes(route: .users).url) else {
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
                let users = try JSONDecoder().decode(Users.self, from: new_data)
                completion(.success(users))
            } catch {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }
}
