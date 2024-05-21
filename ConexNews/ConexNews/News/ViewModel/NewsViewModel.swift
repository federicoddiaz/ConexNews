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
    
    private var newsRepository: NewsRepository
    private var news: Posts? = []
    
    init(delegate: NewsViewModelDelegate? = nil, newsRepository: NewsRepository) {
        self.delegate = delegate
        self.newsRepository = newsRepository
    }
    
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
}
