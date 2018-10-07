//
//  MessageEventCell.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 10.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class MessageEventCell: BWSwipeRevealCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var newMessageView: UIView!
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 8
        newMessageView.layer.cornerRadius = 9
        userAvatarImageView.layer.cornerRadius = 9
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
