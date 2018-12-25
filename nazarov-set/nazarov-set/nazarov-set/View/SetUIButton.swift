//
//  SetUIButton.swift
//  nazarov-set
//
//  Created by user147983 on 12/17/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import UIKit

@IBDesignable class SetUIButton: UIButton {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configure()
        }
        
        private func configure () {
            layer.cornerRadius = DefaultValues.cornerRadius
            layer.borderColor = DefaultValues.borderColor.cgColor
            layer.borderWidth = DefaultValues.borderWidth
            layer.backgroundColor = DefaultValues.backgrounfColor.cgColor
            setTitle("", for: UIControl.State.normal)
            isEnabled = false
            alpha=0
            titleLabel?.font=UIFont.systemFont(ofSize: 26)
        }
    
    public func reset(){
        isEnabled = false
        alpha=0
    }
    
    private func select(withSet isSet: Bool){
        layer.borderWidth = DefaultValues.borderWidthSelected
        if isSet {
            layer.borderColor = DefaultValues.borderColorSet.cgColor
        }else {
            layer.borderColor = DefaultValues.borderColor.cgColor
        }
    }
    
    private func unselect(){
        layer.borderWidth = DefaultValues.borderWidth
        layer.borderColor = DefaultValues.borderColor.cgColor
    }
    
    public func updateViewFromModel(withCard card: SetCard, withSelected selected: Bool, withSet isSet: Bool){
        let title = ButtomViewMapper.getButtonTitle(of: card.cardCount, withSymbol: card.cardSymbol)
        let color = ButtomViewMapper.getColor(of: card.cardColor);
        let attributes = ButtomViewMapper.getButtonAttributedTitle(withFill: card.cardFill, withTitle: title, withColor: color)
        
        setTitle(title, for:     UIControl.State.normal)
        setTitleColor(color, for: UIControl.State.normal)
        setAttributedTitle(attributes, for: UIControl.State.normal)
        
        if selected {
            select(withSet: isSet)
        } else{
            unselect()
        }
        
        isEnabled = true
        alpha=1
    }
    
    public func updateHintView(){
        layer.borderColor = DefaultValues.hintBorderColor.cgColor
    }
        
        //-------------------Constants--------------
        private struct DefaultValues {
            static let cornerRadius: CGFloat = 8.0
            static let borderWidth: CGFloat = 1.0
            static let borderWidthSelected: CGFloat = 3.0
            static let borderColor: UIColor   = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
            static let borderColorSet: UIColor   = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let backgrounfColor: UIColor   = #colorLiteral(red: 0.8611123809, green: 0.878238342, blue: 0.7390054341, alpha: 0.8309859155)
            static let hintBorderColor: UIColor   = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            
        }
    }

