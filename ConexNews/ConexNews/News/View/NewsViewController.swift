//
//  NewsViewController.swift
//  ConexNews
//
//  Created by Federico Díaz on 19/05/2024.
//

import UIKit
import Toast_Swift

final class NewsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let newsCellHeight: CGFloat = 120
    
    internal var viewModel: NewsViewModel!
    
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        viewModel.delegate = self
        viewModel.fetchNews()
    }

    func setViewModel(newsRepository: NewsProtocol) {
        self.viewModel = NewsViewModel(newsRepository: newsRepository)
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NewsTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    private func goToNewsDetail(post: Post) {
        let vc = NewsDetailViewController(nibName: NewsDetailViewController.nibIdentifier, bundle: nil)
        
        vc.setupDetailedNew(post)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? viewModel.numberOfFilteredNews() : viewModel.numberOfNews()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        if let post = isSearching ? viewModel.getFilteredPost(at: indexPath.row) : viewModel.getPost(at: indexPath.row) {
            cell.setupCell(post: post)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let post = isSearching ? viewModel.getFilteredPost(at: indexPath.row) : viewModel.getPost(at: indexPath.row) {
            goToNewsDetail(post: post)
        }
    }
}

extension NewsViewController: NewsViewModelDelegate {
    func fetchedNews() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        self.view.makeToast(message, duration: 2.0, position: .bottom)
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            isSearching = true
            viewModel.filterNewsWith(searchText)
        } else {
            isSearching = false
        }
        tableView.reloadData()
    }
}
