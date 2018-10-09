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
    @IBOutlet weak var textViewPost: UITextField!
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
