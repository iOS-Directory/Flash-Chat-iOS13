//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by FGT MAC on 12/13/19.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    //This is call when a new cell is create
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Instead of hard coding the corner radius
        //We will give the radius base on the size of the message
        //so a large message will still look good
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
