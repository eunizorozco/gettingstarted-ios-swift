//
//  GameManager.swift
//  MemoryGame
//
//  Created by Eunice Orozco on 09/12/2017.
//  Copyright © 2017 TIP. All rights reserved.
//

import Foundation
import UIKit

class GameManager: NSObject {

    var numOfOpenCards: Int = 0
    var recentlyOpenedCard: Card?
    var maxOpenedCards: Int = 2
    
    var numOfMatchedPairs: Int = 0
    var numOfPairs: Int = 0
    
    static var shared: GameManager = GameManager()
    var viewController: UIViewController?
    
    var deckCards: [String] = []
    var totalCards: Int = 0
    
    func openCard (_ card: Card) {
        self.numOfOpenCards = self.numOfOpenCards + 1
        
        if self.numOfOpenCards >= self.maxOpenedCards {
            if let openedCard = self.recentlyOpenedCard,
                openedCard.cardImage == card.cardImage {
                openedCard.isMatched = true
                card.isMatched = true
                
                self.recentlyOpenedCard = nil
                self.numOfOpenCards = 0
                
                self.numOfMatchedPairs = numOfMatchedPairs + 1
            } else {
                let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    card.isOpen = false // we close if it doesnt match
                    self.recentlyOpenedCard?.isOpen = false
                    self.recentlyOpenedCard = nil
                    self.numOfOpenCards = 0
                }
            }
        } else {
            self.recentlyOpenedCard = card
        }
        
        if self.numOfMatchedPairs >= self.numOfPairs {
            let alert = UIAlertController(title: "Hooray!", message: nil, preferredStyle: .alert)
            self.viewController?.present(alert, animated: true, completion: {
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when) {
                    alert.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    struct Deck {
        var cards = [String]()
        var suits : [String] = ["clubs", "diamonds", "hearts", "spades"]
        var pos : [String] = ["queen", "king", "jack"]
        
        init() {
            for i in 2 ..< 13 {
                for j in 0..<suits.count-1 {
                    if i <= 10 {
                        cards.append("\(i )_of_\(suits[j])")
                    } else {
                        cards.append("\(pos[i % 10])_of_\(suits[j])")
                    }
                }
            }
        }
    }
    
    func generateCards () -> [String] {
        let deck = Deck()
        return generateCards(cards: deck.cards)
    }
    
    func generateCards (cards: [String]) -> [String] {
        var cards = cards
        let random = arc4random_uniform(UInt32(cards.count - 1))
        
        let card = cards.remove(at: Int(random))
        // Add a pair of the card
        deckCards.append(card)
        deckCards.append(card)
        
        if deckCards.count < totalCards {
            return generateCards(cards: cards)
        }
        return deckCards
    }
}
