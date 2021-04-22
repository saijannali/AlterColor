//
//  TableViewCell.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

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
