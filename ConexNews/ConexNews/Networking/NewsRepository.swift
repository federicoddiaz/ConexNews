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

protocol NewsProtocol {
    func fetchNews(completion: @escaping (Result<Posts, NetworkError>) -> Void)
}

class NewsRepository: NewsProtocol {
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
                let posts = try JSONDecoder().decode(Posts.self, from: new_data)
                completion(.success(posts))
            } catch {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }
}

class NewsMockRepository: NewsProtocol {
    func fetchNews(completion: @escaping (Result<Posts, NetworkError>) -> Void) {
        let posts = createMockPosts()
        
        completion(.success(posts))
    }
    
    private func createMockPosts() -> Posts {
        let news1 = Post(id: 1, slug: "lorem-ipsum", url: "https://example.com", title: "Lorem Ipsum", content: "Some content", image: "https://example.com/image.jpg", thumbnail: "https://example.com/thumbnail.jpg", status: .published, category: .lorem, publishedAt: "01/01/2024", updatedAt: "02/01/2024", userID: 1)
        
        let news2 = Post(id: 2, slug: "dolor-sit-amet", url: "https://example.com", title: "Dolor Sit Amet", content: "More content", image: "https://example.com/image2.jpg", thumbnail: "https://example.com/thumbnail2.jpg", status: .published, category: .ipsum, publishedAt: "02/01/2024", updatedAt: "03/01/2024", userID: 2)
        
        let news3 = Post(id: 3, slug: "consectetur-adipiscing", url: "https://example.com", title: "Consectetur Adipiscing", content: "Even more content", image: "https://example.com/image3.jpg", thumbnail: "https://example.com/thumbnail3.jpg", status: .published, category: .rutrum, publishedAt: "03/01/2024", updatedAt: "04/01/2024", userID: 3)
        return [news1, news2, news3]
    }
}
