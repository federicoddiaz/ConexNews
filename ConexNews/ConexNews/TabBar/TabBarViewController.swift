//
//  TabBarViewController.swift
//  ConexNews
//
//  Created by Federico Díaz on 19/05/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        setupView()
        
        let newsController = UINavigationController(rootViewController: NewsViewController())
        newsController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        
        let usersController = UINavigationController(rootViewController: UsersViewController())
        usersController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        
        self.viewControllers = [newsController, usersController]
    }

    private func setupView() {
        self.tabBar.tintColor = .systemPink
        self.tabBar.backgroundColor = .black
    }
}
