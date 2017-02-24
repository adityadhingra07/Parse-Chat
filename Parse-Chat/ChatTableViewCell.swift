//
//  ChatTableViewCell.swift
//  Parse-Chat
//
//  Created by Deep S Randhawa on 2/23/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
