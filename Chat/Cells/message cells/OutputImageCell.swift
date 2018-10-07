//
//  OutputImageCell.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 4.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class OutputImageCell: BasicChatCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var backgroundMessageView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = 22
        backgroundMessageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
