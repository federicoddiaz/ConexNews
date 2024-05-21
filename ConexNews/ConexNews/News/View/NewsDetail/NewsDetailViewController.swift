//
//  NewsDetailViewController.swift
//  ConexNews
//
//  Created by Federico Díaz on 21/05/2024.
//

import UIKit

class NewsDetailViewController: UIViewController {

    static let nibIdentifier = "NewsDetailViewController"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //shows back navigation button
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupDetailedNew(_ post: Post) {
        DispatchQueue.main.async { [weak self] in
            
            self?.titleLabel.text = post.title
            self?.contentTextView.text = post.content
            self?.categoryLabel.text = "Category: \(post.category?.rawValue ?? "")"
            self?.dateLabel.text = post.publishedAt
            
            if let url = URL(string: post.image ?? "") {
                
                DispatchQueue.global().async {
                    
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
}
