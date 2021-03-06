//
//  ViewController.swift
//  Concentration
//
//  Created by Walter Niederer on 7/26/18.
//  Copyright © 2018 California State Polytechnic University, Pomona. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.incrementFlipCount(newGame: false)
        updateFlipCountAndScoreCountLabel()
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            //game.scoreCards(at: cardNumber, newGame: false)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons.")
        }
    }
    // Need to reset all cards, reset flipCount, and reinitilize array with all emojis
    @IBAction private func startNewGame(_ sender: UIButton) {
        game.incrementFlipCount(newGame: true)
        game.totalScore = 0
        updateFlipCountAndScoreCountLabel()
        addThreeThemes()
        addTheme(withName: "halloween", forEmojis: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"])
        emojiChoices = themeChoices[selectRandomTheme()]!
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

            }
        }
    }
    
    private var themeChoices = ["halloween":  ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]]
    
    private func addTheme(withName themeName: String, forEmojis emojiChoices: [String]) {
        themeChoices[themeName] = emojiChoices
    }
    
    private func addThreeThemes() {
        addTheme(withName: "sports", forEmojis: ["🏀", "🏈", "⚽️", "🏒", "⚾️", "🎾", "🏐", "🎱"])
        addTheme(withName: "animals", forEmojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"])
        addTheme(withName: "faces", forEmojis: ["😃", "😆", "😂", "🙃", "😭", "😤", "🙄", "😮"])
    }
    
    private func selectRandomTheme() -> String {
        let themes = Array(themeChoices.keys)
        return themes[themes.count.arc4random]
    }
    private lazy var emojiChoices = themeChoices["halloween"]!
    
    private var emoji = Dictionary<Card,String>()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
   
    private func updateFlipCountAndScoreCountLabel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.totalScore)"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
