//
//  SetCard.swift
//  nazarov-set
//
//  Created by user147983 on 12/17/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import Foundation

struct SetCard : Equatable {
    static func ==(first: SetCard, second: SetCard) -> Bool {
        return first.cardColor == second.cardColor &&
            first.cardCount == second.cardCount &&
            first.cardFill == second.cardFill &&
            first.cardSymbol == second.cardSymbol
    }
    
    let cardColor: SetCardColor
    let cardSymbol: SetCardSymbol
    let cardCount: SetCardCount
    let cardFill: SetCardFill
}

enum SetCardColor {
    case first
    case second
    case third
    
    static let allValues = [first, second, third]
}

enum SetCardSymbol {
    case first
    case second
    case third
    
    static let allValues = [first, second, third]
}

enum SetCardCount {
    case first
    case second
    case third
    
    static let allValues = [first, second, third]
}

enum SetCardFill	 {
    case first
    case second
    case third
    
    static let allValues = [first, second, third]
}


