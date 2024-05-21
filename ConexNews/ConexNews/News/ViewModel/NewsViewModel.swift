//
//  NewsViewModel.swift
//  ConexNews
//
//  Created by Federico Díaz on 19/05/2024.
//

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func fetchedNews()
    func showError(message: String)
}

final class NewsViewModel {
    
    weak var delegate: NewsViewModelDelegate?
    private var newsRepository: NewsProtocol
    
    private var news: Posts? = []
    private var filteredNews: Posts? = []
    
    init(delegate: NewsViewModelDelegate? = nil, newsRepository: NewsProtocol) {
        self.delegate = delegate
        self.newsRepository = newsRepository
    }
    
    //MARK: All news
    func fetchNews() {
        newsRepository.fetchNews { [weak self] result in
            
            switch result {
            case .success(let fetchedNews):
                
                self?.news = fetchedNews
                self?.delegate?.fetchedNews()
                
            case .failure(let error):
                self?.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func numberOfNews() -> Int {
        return news?.count ?? 0
    }
    
    func getPost(at index: Int) -> Post? {
        return news?[index]
    }
    
    //MARK: Filtered news
    func filterNewsWith(_ searchText: String) {
        self.filteredNews = news?.filter { post in
            post.title?.lowercased().contains(searchText.lowercased()) ?? false ||
            post.content?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    func numberOfFilteredNews() -> Int {
        return filteredNews?.count ?? 0
    }
    
    func getFilteredPost(at index: Int) -> Post? {
        return filteredNews?[index]
    }
}
