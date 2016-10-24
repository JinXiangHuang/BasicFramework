//
//  PlayersCell.swift
//  BasicFramework
//
//  Created by mr-tech on 16/9/23.
//  Copyright © 2016年 Rainy. All rights reserved.
//

import UIKit

class PlayersCell: UITableViewCell {

    @IBOutlet weak var nameCode: UILabel!
    @IBOutlet weak var gameCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
