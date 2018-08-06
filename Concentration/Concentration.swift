//
//  Concentration.swift
//  Concentration
//
//  Created by Walter Niederer on 7/26/18.
//  Copyright © 2018 California State Polytechnic University, Pomona. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    var flipCount = 0
    var totalScore = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // choose and score card here?
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    totalScore += 2
                //otherwise the cards didn't match, and penalize for each card that has been seen
                } else {
                    if cards[index].hasBeenSeen {
                        totalScore -= 1
                    }
                    if cards[matchIndex].hasBeenSeen {
                        totalScore -= 1
                    }
                    cards[matchIndex].hasBeenSeen = true
                    cards[index].hasBeenSeen = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
         assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // shuffle cards
        for index in cards.indices {
            cards.swapAt(index, cards.count.arc4random)
            if (100.arc4random % 2 == 0) {
                cards.swapAt(index, cards.count - 1)
            } else {
                cards.swapAt(cards.count.arc4random, cards.count.arc4random)
            }
        }
    }
    
    mutating func incrementFlipCount(newGame: Bool){
        if newGame == true {
            flipCount = 0
        } else {
            flipCount += 1
        }
    }
    
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

