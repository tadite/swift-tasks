//
//  SetGame.swift
//  nazarov-set
//
//  Created by user147983 on 12/17/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import Foundation

class SetGame {
    var cardsInDeck = [SetCard]()
    var cardsInGame = [SetCard]()
    var selectedCards = [SetCard]()
    var hintCards = [SetCard]()
    
    var score = 0
    
    init() {
        newGame()
    }
    
    func newGame() {
        score = 0
        cardsInDeck.removeAll()
        cardsInGame.removeAll()
        selectedCards.removeAll()
        hintCards.removeAll()
        
        initializeDeck()
        dealCards(countOfCardsToDeal: 12)
    }
    
    func dealThreeModeCards(){
        if selectedCards.count == 3 && isSet() {
            dealSetCards()
        }
        else {
            dealCards(countOfCardsToDeal: 3)
        }
    }
    
    private func initializeDeck() {
        for fill in SetCardFill.allValues{
            for color in SetCardColor.allValues {
                for count in SetCardCount.allValues {
                    for symbol in SetCardSymbol.allValues {
                        let card = SetCard(cardColor: color, cardSymbol: symbol, cardCount: count, cardFill: fill)
                        cardsInDeck.append(card)
                    }
                }
            }
        }
    }
    
    private func dealCard(){
        let randomCardFromDeck = cardsInDeck.remove(at: cardsInDeck.count.arc4Random())
        cardsInGame.append(randomCardFromDeck)
    }
    
    private func dealCards(countOfCardsToDeal cardsCount: Int){
        for _ in 1...cardsCount {
            dealCard()
        }
    }
    
    public func isSet() -> Bool {
        return checkSet(forCards: selectedCards)
    }
    
    private func checkSet(forCards cards: [SetCard]) -> Bool{
        if cards.count != 3 {
            return false
        }
        
        if cards[0].cardColor == cards[1].cardColor {
            if cards[0].cardColor != cards[2].cardColor {
                return false
            }
        } else if cards[1].cardColor == cards[2].cardColor {
            return false
        } else if (cards[0].cardColor == cards[2].cardColor) {
            return false
        }
        
        if cards[0].cardCount == cards[1].cardCount {
            if cards[0].cardCount != cards[2].cardCount {
                return false
            }
        } else if cards[1].cardCount == cards[2].cardCount {
            return false
        } else if (cards[0].cardCount == cards[2].cardCount) {
            return false
        }
        
        if cards[0].cardFill == cards[1].cardFill {
            if cards[0].cardFill != cards[2].cardFill {
                return false
            }
        } else if cards[1].cardFill == cards[2].cardFill {
            return false
        } else if (cards[0].cardFill == cards[2].cardFill) {
            return false
        }
        
        if cards[0].cardSymbol == cards[1].cardSymbol {
            if cards[0].cardSymbol != cards[2].cardSymbol {
                return false
            }
        } else if cards[1].cardSymbol == cards[2].cardSymbol {
            return false
        } else if (cards[0].cardSymbol == cards[2].cardSymbol) {
            return false
        }
        
        return true
    }
    
    func isCardSelected(card: SetCard) -> Bool {
        return selectedCards.index(of: card) != nil
    }
    
    private func dealSetCards(){
        selectedCards.forEach { (setCard) in
            let selectedCardInGameIndex = cardsInGame.index(of: setCard)
            cardsInGame.remove(at: selectedCardInGameIndex!)
            if cardsInDeck.count > 0 {
                let selectedCard = cardsInDeck.remove(at: cardsInDeck.count.arc4Random())
                cardsInGame.insert(selectedCard, at: selectedCardInGameIndex!)
            }
        }
        score += 3
        selectedCards.removeAll()
    }
    
    func select(card: SetCard){
        if selectedCards.count == 3 && isSet() {
            dealSetCards()
        }
        else if selectedCards.count == 3 && !isSet() {
            selectedCards.removeAll()
            score -= 1
        }
        
        if let cardToSelect = selectedCards.index(of: card) {
            selectedCards.remove(at: cardToSelect)
        } else {
            selectedCards.append(card)
        }
    }
    
    func hint(){
        for card1 in cardsInGame {
            for card2 in cardsInGame {
                for card3 in cardsInGame {
                    if card1 != card2 || card2 != card3{
                        let isSet = checkSet(forCards: [card1,card2,card3])
                        if isSet {
                            return hintCards.append(contentsOf: [card1,card2,card3])
                        }
                    }
                }
            }
        }
    }
    
    func removeHint(){
        hintCards.removeAll()
    }
}
