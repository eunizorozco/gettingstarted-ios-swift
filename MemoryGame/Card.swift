//
//  Card.swift
//  MemoryGame
//
//  Created by Eunice Orozco on 08/12/2017.
//  Copyright © 2017 TIP. All rights reserved.
//

import Foundation
import UIKit

class Card: UIImageView {
    
    var cardImage: String = "back"
    
    var isOpen: Bool = false {
        didSet {
            let imgName = isOpen ? cardImage: "back"
            self.image = UIImage(named: imgName)
            self.isUserInteractionEnabled = !isOpen
        }
    }
    
    var isMatched: Bool = false {
        didSet {
            self.isOpen = self.isMatched
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        self.addGestureRecognizer(tap)
    }
    
    @objc func didTap () {
        self.isOpen = !self.isOpen
        GameManager.shared.openCard(self)
    }
}


