//
//  UsersRepository.swift
//  ConexNews
//
//  Created by Federico Díaz on 21/05/2024.
//

import Foundation

protocol UsersProtocol {
    func fetchUsers(completion: @escaping (Result<Users, NetworkError>) -> Void)
}

class UsersRepository: UsersProtocol {
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

class UsersMockRepository: UsersProtocol {
    func fetchUsers(completion: @escaping (Result<Users, NetworkError>) -> Void) {
        let users = createMockUsers()
        completion(.success(users))
    }
    
    private func createMockUsers() -> Users {
        let user1 = User(
            id: 1,
            firstname: "John",
            lastname: "Doe",
            email: "johndoe@example.com",
            birthDate: "1973-01-22",
            login: Login(
                uuid: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
                username: "johndoe",
                password: "jsonplaceholderOrg",
                md5: "c1328472C5794A25723600F71C1B4586",
                sha1: "the35544A31Cc19Bd6520Af116554873167117F4D94",
                registered: "2023-01-10T10:03:20.022Z"
            ),
            address: Address(
                street: "123 Main Street",
                suite: "Apt. 4",
                city: "Anytown",
                zipcode: "the123456789",
                geo: Geo(lat: "42.1234", lng: "-71.2345")
            ),
            phone: "the5555551234",
            website: "www.johndoe.com",
            company: Company(
                name: "ABC Company",
                catchPhrase: "Innovative solutions for all your needs",
                bs: "Marketing"
            )
        )
        
        let user2 = User(
            id: 2,
            firstname: "Jane",
            lastname: "Smith",
            email: "janesmith@example.com",
            birthDate: "1985-05-15",
            login: Login(
                uuid: "2a1eed02-9430-4d68-901f-c0d4c1c3bf23",
                username: "janesmith",
                password: "jsonplaceholderOrg",
                md5: "c1328472C5794A25723600F71C1B4586",
                sha1: "the35544A31Cc19Bd6520Af116554873167117F4D94",
                registered: "2023-01-11T11:03:20.022Z"
            ),
            address: Address(
                street: "456 Oak Avenue",
                suite: "Apt. 7",
                city: "Anytown",
                zipcode: "the123456789",
                geo: Geo(lat: "41.9876", lng: "-71.8765")
            ),
            phone: "the5555555678",
            website: "www.janesmith.com",
            company: Company(
                name: "XYZ Corporation",
                catchPhrase: "Quality products for a better tomorrow",
                bs: "Sales"
            )
        )
        
        let user3 = User(
            id: 3,
            firstname: "Alice",
            lastname: "Johnson",
            email: "alicejohnson@example.com",
            birthDate: "1990-12-05",
            login: Login(
                uuid: "3a2eed03-9430-4d68-901f-c0d4c1c3bf24",
                username: "alicejohnson",
                password: "jsonplaceholderOrg",
                md5: "c1328472C5794A25723600F71C1B4586",
                sha1: "the35544A31Cc19Bd6520Af116554873167117F4D94",
                registered: "2023-01-12T12:03:20.022Z"
            ),
            address: Address(
                street: "789 Pine Street",
                suite: "Apt. 10",
                city: "Anytown",
                zipcode: "the123456789",
                geo: Geo(lat: "41.5432", lng: "-72.0987")
            ),
            phone: "the5555559012",
            website: "www.alicejohnson.com",
            company: Company(
                name: "123 Solutions",
                catchPhrase: "Solving problems with simplicity",
                bs: "Technology"
            )
        )
        return [user1, user2, user3]
    }
}
