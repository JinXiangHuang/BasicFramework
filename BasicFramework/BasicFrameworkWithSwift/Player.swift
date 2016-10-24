//
//  Player.swift
//  BasicFramework
//
//  Created by mr-tech on 16/9/23.
//  Copyright © 2016年 Rainy. All rights reserved.
//

import Foundation
import UIKit

class Player: NSObject {
    var name: String
    var game: String
    var rating: Int
    
    init(name: String, game: String, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
        super.init()
    }
}
