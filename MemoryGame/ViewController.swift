//
//  ViewController.swift
//  MemoryGame
//
//  Created by Eunice Orozco on 08/12/2017.
//  Copyright © 2017 TIP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // count the rows and cols
        let rows = self.cardsStackView.arrangedSubviews as? [UIStackView]
        let rowsCount = rows?.count ?? 0
        let colCount = rows?.first?.arrangedSubviews.count ?? 0
    
        let manager = GameManager.shared
        manager.totalCards = (rowsCount * colCount)
        manager.numOfPairs = manager.totalCards / 2
        
        // generate cards
        var deckCards = manager.generateCards()

        rows?.forEach { (cardStack) in // iterates over the row
            cardStack.arrangedSubviews.forEach({ (cardView) in
                // pick random card from deck
                let random = arc4random_uniform(UInt32(deckCards.count - 1))
                let cardImage = deckCards.remove(at: Int(random))
                (cardView as? Card)?.cardImage = cardImage
                
                let maxMatchedCard = manager.maxMatchedCards
                manager.maxMatchedCards = maxMatchedCard + 1
            })
        }
        manager.viewController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

