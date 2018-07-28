//
//  Concentration.swift
//  Concentration
//
//  Created by Walter Niederer on 7/26/18.
//  Copyright © 2018 California State Polytechnic University, Pomona. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        //print("Cards original: \(cards)")
        for index in cards.indices {
            cards.swapAt(index, Int(arc4random_uniform(UInt32(cards.count))))
            if (Int(arc4random_uniform(100)) % 2 == 0) {
                cards.swapAt(index, cards.count - 1)
                //print("Cards reversed: \(cards)")
            } else {
                cards.swapAt(Int(arc4random_uniform(UInt32(cards.count))), Int(arc4random_uniform(UInt32(cards.count))))
                //print("Cards rando changed: \(cards)")
            }
        }
    }
}

