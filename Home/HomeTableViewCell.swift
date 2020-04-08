//  HomeTableViewCell.swift
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status :Completed-----------------------------------------------

import UIKit // for UI object

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var rect: UIImageView!
    
    @IBOutlet weak var robot: UIImageView!
    
    @IBOutlet weak var TEXT: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
