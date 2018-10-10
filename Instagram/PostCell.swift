//
//  PostCell.swift
//  Instagram
//
//  Created by Joseph Andy Feidje on 10/9/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var textViewPost: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.cornerRadius = 40
        userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
