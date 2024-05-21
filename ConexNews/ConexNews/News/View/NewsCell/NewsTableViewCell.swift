//
//  NewsTableViewCell.swift
//  ConexNews
//
//  Created by Federico Díaz on 20/05/2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "NewsTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    private var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(post: Post) {
        self.post = post
        self.titleLabel.text = post.title
        self.contentLabel.text = post.content
        self.categoryLabel.text = "Category: \(post.category?.rawValue ?? "")"
        self.dateLabel.text = post.publishedAt
        
        if let url = URL(string: post.thumbnail ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
}
