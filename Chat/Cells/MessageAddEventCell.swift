//
//  MessageAddEventCell.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 10.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class MessageAddEventCell: UITableViewCell {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var avatarEventImageView: UIImageView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
