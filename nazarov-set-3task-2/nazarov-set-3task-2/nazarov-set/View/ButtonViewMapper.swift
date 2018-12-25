//
//  ButtonViewMapper.swift
//  nazarov-set
//
//  Created by user147983 on 12/17/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import Foundation
import UIKit

class ButtomViewMapper {
    
    public static func getSymbol(of modelSymbol: SetCardSymbol) -> String{
        switch modelSymbol {
        case .first:
            return "▲"
        case .second:
            return "●"
        case .third:
            return "◼︎"
        }
    }
    
    public static func getColor(of modelColor: SetCardColor) -> UIColor{
        switch modelColor {
        case .first:
            return UIColor.red
        case .second:
            return UIColor.black
        case .third:
            return UIColor.blue
        }
    }
    
    public static func getButtonTitle(of modelCount: SetCardCount, withSymbol modelSymbol: SetCardSymbol) -> String {
        let separator = "\n"
        let symbol = getSymbol(of: modelSymbol)
        switch modelCount {
        case .first:
            return symbol
        case .second:
            return "\(symbol)\(separator)\(symbol)"
        case .third:
            return "\(symbol)\(separator)\(symbol)\(separator)\(symbol)"
        }
    }
    
    public static func getButtonAttributedTitle(withFill modelFill: SetCardFill, withTitle title: String, withColor color: UIColor) -> NSAttributedString {
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        switch modelFill {
        case .first:
            attributes[.strokeWidth] = 8
            attributes[.foregroundColor] = color
        case .second:
            attributes[.strokeWidth] = -8
            attributes[.foregroundColor] = color
        case .third:
            attributes[.strokeWidth] = -8
            attributes[.foregroundColor] = color.withAlphaComponent(0.25)
        }
        
        return NSAttributedString(string: title, attributes: attributes)
    }
}
