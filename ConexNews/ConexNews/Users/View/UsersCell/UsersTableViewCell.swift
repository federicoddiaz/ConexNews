//
//  UsersTableViewCell.swift
//  ConexNews
//
//  Created by Federico Díaz on 21/05/2024.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    static let reuseIdentifier = "UsersTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(user: User) {
        self.nameLabel.text = "\(user.lastname ?? ""), \(user.firstname ?? "")"
        self.emailLabel.text = user.email
    }
    
}
