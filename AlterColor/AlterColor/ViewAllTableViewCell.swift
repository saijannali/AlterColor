//
//  TableViewCell.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

// Assignment 02 4/27/2021
//
// Alter Color
//
// Serena Press - sapress@iu.edu
// Sai Jannali - sjannali@iu.edu
// Aidan Lesh - ailesh@iu.edu

import UIKit

class ViewAllTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail : UIImageView!
    @IBOutlet weak var filenameLabel : UILabel!
    @IBOutlet weak var dateModifiedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
