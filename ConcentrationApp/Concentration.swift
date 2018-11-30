//
//  Concentration.swift
//  ConcentrationApp
//
//  Created by Andi Maroge on 10/23/18.
//  Copyright © 2018 Andi Maroge. All rights reserved.
//

import Foundation
class Concentration {
    
    var cards = [Card]()
    
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var scoreCount = 0
    
    //initializes the cards from the controller
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        shuffleCards()
    }
    //when the user selects a card from the UI, see if the cards match
    func chooseCard(at index: Int){
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    //increase score by 2 points when user matches the cards
                    scoreCount += 2
                }
                    
                else{
                    
                    //decrease score by 1 point if user does not match cards
                    scoreCount -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            }
            else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                    
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                flipCount += 1
            }
        }
    }
    
    
    
    //shuffles the cards
    func shuffleCards(){
        for index in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let tempArrayValueForSwitch = cards[index]
            cards[index] = cards[randomIndex]
            cards[randomIndex] = tempArrayValueForSwitch
        }
    }
    //resets the game
    public func resetGameForNewGame(){
        cards = []
        indexOfOneAndOnlyFaceUpCard = nil
        scoreCount = 0
        flipCount = 0
    }
    //get methods for retrieving flip count and score to update the UI in the view.
    public func getScoreCount() -> Int{ return scoreCount }
    public func getFlipCount() -> Int{ return flipCount }
}
