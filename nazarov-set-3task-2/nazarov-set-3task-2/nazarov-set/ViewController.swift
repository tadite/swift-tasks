//
//  ViewController.swift
//  nazarov-set
//
//  Created by user147983 on 12/17/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet var cardButtons: [SetUIButton]!
    @IBOutlet weak var dealThreeMoreCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var setGameView: SetGameView!{
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(onSwipe))
            swipe.direction = .down
            setGameView.addGestureRecognizer(swipe)
            
            let rotate = UIRotationGestureRecognizer(target: self,
                                                     action: #selector(onRotation))
            setGameView.addGestureRecognizer(rotate)
        }
    }
    
    let setGame = SetGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @objc private func onSwipe(){
        dealMoreCards()    }
    
    @objc private func onRotation(){
        setGame.reshuffle()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        scoreLabel.text = "Score: \(setGame.score)"
        updateCardsViewFromModel()
    }
    
    private func updateCardsViewFromModel(){
        removeUnusedCardViews()
        
        for index in setGame.cardsInGame.indices {
            let card = setGame.cardsInGame[index]
            if  index >= (setGameView.cardViews.count) {
                let cardView = SetCardView()
                updateCardView(forView: cardView, withModel: card)
                addTapListener(forCardView: cardView)
                setGameView.cardViews.append(cardView)
            } else {
                let cardView = setGameView.cardViews [index]
                updateCardView(forView: cardView, withModel: card)
            }
        }
        
    }
    
    private func removeUnusedCardViews(){
        if setGameView.cardViews.count - setGame.cardsInGame.count > 0 {
            let cardViews = setGameView.cardViews [..<setGame.cardsInGame.count ]
            setGameView.cardViews = Array(cardViews)
        }
    }
    
    private func addTapListener(forCardView cardView: SetCardView){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCardTap(recognizedBy:)))
        tapRecognizer.numberOfTapsRequired=1
        cardView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func onCardTap(recognizedBy recognizer: UITapGestureRecognizer){
        switch recognizer.state {
        case .ended:
            if let cardView = recognizer.view! as? SetCardView {
                let cardViewIndex = setGameView.cardViews.index(of: cardView)
                setGame.select(card: setGame.cardsInGame[cardViewIndex!])
            }
        default: break
        }
        updateViewFromModel()
    }
    
    private func updateCardView(forView cardView: SetCardView, withModel modelCard: SetCard){
        cardView.colorInt = 1 +  (SetCardColor.allValues.firstIndex(of: modelCard.cardColor) ?? 1)
        cardView.fillInt = 1 + (SetCardFill.allValues.firstIndex(of: modelCard.cardFill) ?? 1)
        cardView.count = 1 + (SetCardCount.allValues.firstIndex(of: modelCard.cardCount) ?? 1)
        cardView.symbolInt = 1 +  (SetCardSymbol.allValues.firstIndex(of: modelCard.cardSymbol) ?? 1)
        cardView.isSelected = setGame.isCardSelected(card: modelCard)
        cardView.isSet = cardView.isSelected && setGame.isSet()
        cardView.isHint = setGame.hintCards.contains(modelCard)
    }
    
    @IBAction private func dealThreeMoreCards(_ sender: UIButton){
        dealMoreCards()
    }
    
    private func dealMoreCards(){
        setGame.dealThreeModeCards()
        updateViewFromModel()
    }
    
    @IBAction private func hint(_ sender: UIButton){
            setGame.hint()
            updateViewFromModel()
            setGame.removeHint()
    }
    
    @IBAction private func shuffle(_ sender: UIButton){
        onRotation()
    }
}

