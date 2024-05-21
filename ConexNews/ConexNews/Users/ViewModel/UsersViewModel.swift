//
//  UsersViewModel.swift
//  ConexNews
//
//  Created by Federico Díaz on 19/05/2024.
//

import Foundation

protocol UsersViewModelDelegate: AnyObject {
    func fetchedUsers()
    func showError(message: String)
}

final class UsersViewModel {
    
    weak var delegate: UsersViewModelDelegate?
    private var usersRepository: UsersRepository
    
    private var users: Users? = []
    
    init(delegate: UsersViewModelDelegate? = nil, usersRepository: UsersRepository) {
        self.delegate = delegate
        self.usersRepository = usersRepository
    }
    
    func fetchUsers() {
        usersRepository.fetchUsers { [weak self] result in
            
            switch result {
            case .success(let fetchedUsers):
                
                self?.users = fetchedUsers
                self?.delegate?.fetchedUsers()
                
            case .failure(let error):
                self?.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func numberOfUsers() -> Int {
        return users?.count ?? 0
    }
    
    func getUser(at index: Int) -> User? {
        return users?[index]
    }
}
