//
//  ConcentrationThemes.swift
//  ConcentrationApp
//
//  Created by Andi Maroge on 10/30/18.
//  Copyright © 2018 Andi Maroge. All rights reserved.
//


import Foundation

//class for different themes in the game
class ConcentrationThemes {
    
    enum Theme: String {
            case Holloween = "🦇😱🙀😈🎃👻🍭🍬🍎"
            case Emoticons =  "😀🤓😎😬🤠😺😯😳🤩"
            case Animals = "🦖🐢🦆🦅🐔🐷🐸🦉🐑"
    }
    
    //retrieves a random theme from the enum string
    public func getRandomThemeEmojis() -> Array<Character>{
        
        var themeToGetRandomly = [Theme.Holloween, Theme.Emoticons, Theme.Animals]
        let index = Int(arc4random_uniform(UInt32(themeToGetRandomly.count)))
        
        let themesString = themeToGetRandomly[index].rawValue
        let themesArray = Array(themesString)
        
    
        return themesArray
    }
}
