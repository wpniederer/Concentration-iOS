//
//  Card.swift
//  Concentration
//
//  Created by Walter Niederer on 7/26/18.
//  Copyright © 2018 California State Polytechnic University, Pomona. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeen = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
