//  HomeTableViewCell2.swift
//  Home
// Copyright © 2020 Darakson. All rights reserved.
//------------------------Refractor Status : Completed-----------------------------------------------
import UIKit

class HomeTableViewCell2: UITableViewCell {
//rect
// robot
//TEXT

    @IBOutlet weak var rect: UIImageView!
    @IBOutlet weak var robot: UIImageView!
    @IBOutlet weak var TEXT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
