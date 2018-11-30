//
//  ViewController.swift
//  ConcentrationApp
//
//  Created by Andi Maroge on 10/23/18.
//  Copyright © 2018 Andi Maroge. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {
    
    //initializes the game, Concentration with the number of pairs of cards
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    //array of card buttons
    @IBOutlet var cardButtons: [UIButton]!{
        didSet{
            for button in 0..<cardButtons.count {
                cardButtons[button].layer.cornerRadius = 10
            }
        }
    }
    //new game label
    @IBOutlet weak var newGameLabel: UIButton! {
        didSet{
            
            newGameLabel.layer.cornerRadius = 10
            
        }
    }
    var themes = ConcentrationThemes()
    lazy var emojiChoices = themes.getRandomThemeEmojis()
    var emoji = [Int:String]()
    //keep track of score count and update the label when the score changes
    var scoreCount: Int? {
        didSet {
            if let score = scoreCount {
                scoreCountLabel!.text = "Score: \(score)"
            }
        }
    }
    //keep track of flip count and update the label when the flip count changes
    var flipCount: Int? {
        didSet {
            if let flips = flipCount {
                flipCountLabel!.text = "Flips: \(flips)"
            }
        }
    }
    //retrieve the emoji for the card
    func emoji(for card: Card) -> String {
        
        if emojiChoices.count > 0, emoji[card.identifier] == nil {
            
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            
            emoji[card.identifier] = String(emojiChoices.remove(at: randomIndex))
            print(" card identifier:  \(card.identifier)")
            
        }
        return emoji[card.identifier] ?? "?"
    }
    
    //flips the card by changing the background color and title of the card
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        else {
            
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0): #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    //when the user touches a button in the UI, check if the cards match and update view
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("chosen card was not in cardButtons")
        }
        scoreCount = game.getScoreCount()
        flipCount = game.getFlipCount()
    }
    
    //start a new game button function
    @IBAction func startNewGame(){
        emoji = [Int: String]()
        game.resetGameForNewGame()
        self.game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        Card.resetIdentifierFactory()
        self.themes = ConcentrationThemes()
        emojiChoices = themes.getRandomThemeEmojis()
        updateViewFromModel()
        scoreCount = 0
        flipCount = 0
    }
    
    
}
