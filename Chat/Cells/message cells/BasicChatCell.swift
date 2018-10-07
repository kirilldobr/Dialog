//
//  BasicChatCell.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 28/03/2017.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class BasicChatCell: UITableViewCell {
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!

    @IBOutlet weak var leadingMyMessageConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        selectionImageView.isHighlighted = false
        
        //selectionImageView?.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        selectionImageView.isHighlighted =  !selectionImageView.isHighlighted
        
        
        // Configure the view for the selected state
    }
  
    
    func test(sender: AnyObject){
        
    }
    
    func copy(sender: AnyObject){
        
    }
    
    func customMenuItemTapped(sender: UIMenuController) {
        // implement custom action here
    }
    
}
