//
//  FriendCell.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 10.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 24
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
