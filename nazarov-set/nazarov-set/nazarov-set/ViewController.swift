//
//  ViewController.swift
//  nazarov-set
//
//  Created by user147983 on 12/17/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardButtons: [SetUIButton]!
    @IBOutlet weak var dealThreeMoreCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let setGame = SetGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resetButtons() {
        for button in cardButtons {
            button.reset()
        }
    }
    
    private func updateViewFromModel() {
        var cardButtonIndex = 0
        resetButtons()
        scoreLabel.text = "Score: \(setGame.score)"
        for card in setGame.cardsInGame {
            let button = cardButtons[cardButtonIndex]
            
            button.updateViewFromModel(withCard: card, withSelected: setGame.isCardSelected(card: card), withSet: setGame.isSet())

            cardButtonIndex += 1
        }
    }
    
    @IBAction private func selectCard(_ sender: SetUIButton) {
        let cardIndex = cardButtons.index(of: sender)
        if cardIndex! < setGame.cardsInGame.count {
            setGame.select(card: setGame.cardsInGame[cardIndex!])
        }
        updateViewFromModel()
    }
    
    @IBAction private func dealThreeMoreCards(_ sender: UIButton){
        if setGame.cardsInGame.count < 24 || setGame.isSet() {
            setGame.dealThreeModeCards()
            updateViewFromModel()
        }
    }
    
    @IBAction private func hint(_ sender: UIButton){
            setGame.hint()
            updateHintsViewFromModel()
            setGame.removeHint()
    }
    
    private func updateHintsViewFromModel(){
        var cardButtonIndex = 0
        for card in setGame.cardsInGame {
            let button = cardButtons[cardButtonIndex]
            
            if setGame.hintCards.contains(card){
                button.updateHintView()
            }
            
            cardButtonIndex += 1
        }
    }


}

