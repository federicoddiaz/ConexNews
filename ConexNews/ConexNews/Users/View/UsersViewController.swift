//
//  UsersViewController.swift
//  ConexNews
//
//  Created by Federico Díaz on 19/05/2024.
//

import UIKit
import Toast_Swift

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let usersCellHeight: CGFloat = 69
    
    private var viewModel = UsersViewModel(usersRepository: UsersRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        setupTableView()
        viewModel.fetchUsers()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: UsersTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
    }
    
    private func showLocation(user: User) {
        guard let street = user.address?.street, let city = user.address?.city, let zipCode = user.address?.zipcode else {
            
            self.view.makeToast("Invalid address", duration: 2.0, position: .bottom)
            return
        }
        
        let address = "\(street), \(city), \(zipCode)"
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let googleMapsURLString = "comgooglemaps://?q=\(encodedAddress)"
        
        if let googleMapsURL = URL(string: googleMapsURLString), UIApplication.shared.canOpenURL(googleMapsURL) {
            UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
        } else {
            let googleMapsWebURLString = "https://www.google.com/maps?q=\(encodedAddress)"
            if let googleMapsWebURL = URL(string: googleMapsWebURLString) {
                UIApplication.shared.open(googleMapsWebURL, options: [:], completionHandler: nil)
            }
        }
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return usersCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseIdentifier, for: indexPath) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        
        if let user = viewModel.getUser(at: indexPath.row) {
            cell.setupCell(user: user)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = viewModel.getUser(at: indexPath.row) {
            self.showLocation(user: user)
        }
    }
}

extension UsersViewController: UsersViewModelDelegate {
    func fetchedUsers() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        self.view.makeToast(message, duration: 2.0, position: .bottom)
    }
}
