//
//  HomeTableViewCell2.swift
//  Home
//
//  Created by Lama Alherbish on 08/02/2020.
//  Copyright © 2020 Lama Alherbish. All rights reserved.
//

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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
