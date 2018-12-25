//
//  SetGameView.swift
//  nazarov-set
//
//  Created by user147983 on 12/18/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import UIKit

@IBDesignable class SetGameView: UIView {
    
    var cardViews = [SetCardView]() {
        willSet { removeSubviews() }
        didSet { addSubviews(); setNeedsLayout() }
    }
    
    private func removeSubviews() {
        for card in cardViews {
            card.removeFromSuperview()
        }
    }
    
    private func addSubviews() {
        for card in cardViews {
            addSubview(card)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var grid = Grid(
            layout: Grid.Layout.aspectRatio(DefaultValues.cardAspectRatio),
            frame: bounds)
        grid.cellCount = cardViews.count
        for row in 0..<grid.dimensions.rowCount {
            for column in 0..<grid.dimensions.columnCount {
                if cardViews.count > (row * grid.dimensions.columnCount + column) {
                    cardViews[row * grid.dimensions.columnCount + column].frame = grid[row,column]!.insetBy(
                        dx: DefaultValues.marginX, dy: DefaultValues.marginY)
                }
            }
        }
    }
    
    struct DefaultValues {
        static let cardAspectRatio: CGFloat = 0.6
        static let marginX: CGFloat  = 3.0
        static let marginY: CGFloat  = 3.0
        
    }
    
}
