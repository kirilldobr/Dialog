//
//  MessagePeopleCell.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 20.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class MessagePeopleCell: BWSwipeRevealCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var newMessageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 24
        newMessageView.layer.cornerRadius = 9
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
