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
        self.viewControllers = [getNewsController(), getUsersController()]
    }
    
    private func getNewsController() -> UINavigationController {
        let newsVC = NewsViewController()
        newsVC.setViewModel(newsRepository: NewsRepository())
        
        let newsController = UINavigationController(rootViewController: newsVC)
        newsController.setNavigationBarHidden(true, animated: false)
        newsController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        
        return newsController
    }
    
    private func getUsersController() -> UINavigationController {
        let usersVC = UsersViewController()
        usersVC.setViewModel(usersRepository: UsersRepository())
        
        let usersController = UINavigationController(rootViewController: usersVC)
        usersController.setNavigationBarHidden(true, animated: false)
        usersController.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        
        return usersController
    }
}
