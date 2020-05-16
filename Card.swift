//
//  Card.swift
//  HW1_MelanyCygielGdud
//
//  Created by user167402 on 5/6/20.
//  Copyright © 2020 user167402. All rights reserved.
//
import UIKit
import Foundation

class Card {
    var tagCard : Int
    var isShown : Bool = false
    var imageCard : UIButton!
    
    init(card : Card) {
        self.tagCard = card.tagCard
        self.isShown = card.isShown
        self.imageCard = card.imageCard
    }
}
