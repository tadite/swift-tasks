//
//  SetCardView.swift
//  nazarov-set
//
//  Created by user147983 on 12/18/18.
//  Copyright © 2018 user147983. All rights reserved.
//

import UIKit

@IBDesignable class SetCardView: UIView {
    
    //==Setters start==
    @IBInspectable
    var cardBackgroundColor: UIColor = UIColor.white { didSet { setNeedsDisplay()} }
    
    @IBInspectable
    var isSelected:Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    @IBInspectable
    var isSet: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var isHint: Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    @IBInspectable
    var symbolInt: Int = 1 { didSet {
        switch symbolInt {
        case 1: symbol = .squiggle
        case 2: symbol = .oval
        case 3: symbol = .diamond
        default: break
        }
    }}
    @IBInspectable
    var fillInt: Int = 1 { didSet {
        switch fillInt {
        case 1: fill = .border
        case 2: fill = .stripes
        case 3: fill = .fill
        default: break
        }
    }}
    @IBInspectable
    var colorInt: Int = 1 { didSet {
        switch colorInt {
        case 1: color = DefaultValues.Colors.first
        case 2: color = DefaultValues.Colors.second
        case 3: color = DefaultValues.Colors.third
        default: break
        }
    }}

    
    @IBInspectable
    var count: Int = 1 {
        didSet {setNeedsDisplay(); setNeedsLayout()}
    }
    
    private var color = DefaultValues.Colors.first {
        didSet { setNeedsDisplay(); setNeedsLayout()}
    }
    private var fill = Fill.stripes {
        didSet { setNeedsDisplay(); setNeedsLayout()}
    }
    private var symbol = Symbol.squiggle {
        didSet { setNeedsDisplay(); setNeedsLayout()}
    }
    
    private enum Symbol: Int {
        case diamond
        case squiggle
        case oval
    }
    
    private enum Fill: Int {
        case border
        case stripes
        case fill
    }
    //==Setters end==
    
    //==Drawing start=
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds,
                                       cornerRadius: 0)
        layer.borderWidth=2
        
        layer.borderColor=DefaultValues.defaultBorderColor
        layer.backgroundColor = DefaultValues.backgrounfColor
        if(isSelected){
            layer.borderColor=DefaultValues.selectedColor
            if (isSet){
                layer.borderColor=DefaultValues.setColor
            }
        }else{
        }
        if isHint{
            layer.borderColor=DefaultValues.hintColor
        }
        cardBackgroundColor.setFill()
        roundedRect.fill()
        
        drawCard()
    }
    
    private func drawCard(){
        color.setFill()
        color.setStroke()
        
        let centerSymbolRect = CGRect(origin: CGPoint(x:drawRect.minX, y:drawRect.midY-symbolRectHeight/2), size: CGSize(width: drawRect.size.width, height: symbolRectHeight))
        switch count {
        case 1:
            drawSymbol(insideRect: centerSymbolRect)
        case 2:
            let firstRect = centerSymbolRect.offsetBy(dx: 0, dy: -symbolRectHeightWithMargin/2)
            drawSymbol(insideRect: firstRect)
            let secondRect = firstRect.offsetBy(dx: 0, dy: symbolRectHeightWithMargin)
            drawSymbol(insideRect: secondRect)
            break
        case 3:
            let firstRect = centerSymbolRect.offsetBy(dx: 0, dy: -symbolRectHeightWithMargin)
            drawSymbol(insideRect: firstRect)
            let secondRect = firstRect.offsetBy(dx: 0, dy: symbolRectHeightWithMargin)
            drawSymbol(insideRect: secondRect)
            let thirdRect = secondRect.offsetBy(dx: 0, dy: symbolRectHeightWithMargin)
            drawSymbol(insideRect: thirdRect)
            break
        default:
            break
        }
    }
    
    private func drawSymbol(insideRect rect: CGRect){
        let path: UIBezierPath
        switch symbol {
        case .diamond:
            path = pathForDiamond(inside: rect)
        case .squiggle:
            path = pathForSquiggle(inside: rect)
        case .oval:
            path = pathForOval(inside: rect)
        }
        
        path.lineWidth = DefaultValues.symbolStrokeWidth
        path.stroke()
        switch fill {
            case .fill:
                path.fill()
            case .stripes:
                makeStripes(forPath: path, insideRect: rect)
            default:
                break
        }
    }
    
    private func makeStripes(forPath path: UIBezierPath, insideRect rect: CGRect){
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        path.addClip()
        makeStripes(forRect: rect)
        context?.restoreGState()
    }
    
    private func makeStripes(forRect rect: CGRect){
        let stripe = UIBezierPath()
        stripe.lineWidth = 1.0
        stripe.move(to: CGPoint(x: rect.minX, y: bounds.minY ))
        stripe.addLine(to: CGPoint(x: rect.minX, y: bounds.maxY))
        let marginBetweenStriper = rect.width*0.05
        let stripeCount = Int(rect.width / marginBetweenStriper)
        for _ in 1...stripeCount {
            let translation = CGAffineTransform(translationX: marginBetweenStriper, y: 0)
            stripe.apply(translation)
            stripe.stroke()
        }
    }
    //==Drawing end==
    
    //==Bezzier Paths start==
    private func pathForDiamond(inside rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x:rect.midX, y:rect.maxY))
        path.addLine(to: CGPoint(x:rect.maxX, y:rect.midY))
        path.addLine(to: CGPoint(x:rect.midX, y:rect.minY))
        path.close()
        return path
    }
    
    private func pathForSquiggle(inside rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addCurve(to: CGPoint(x: rect.maxX-rect.width/4, y: rect.midY), controlPoint1: CGPoint(x: rect.minX+rect.width*3/4, y: rect.minY)
            , controlPoint2: CGPoint(x: rect.minX+rect.width/6, y: rect.maxY))
        
        path.addCurve(to: CGPoint(x: rect.maxX-rect.width/8, y: rect.minY), controlPoint1: CGPoint(x: rect.maxX, y: rect.midY-rect.height/4)
            , controlPoint2: CGPoint(x: rect.maxX, y: rect.minY))
        
        let mirrorPath = UIBezierPath(cgPath: path.cgPath)
        mirrorPath.apply(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        mirrorPath.apply(CGAffineTransform.identity.translatedBy(x: bounds.width-rect.width/8, y: bounds.height-rect.height/2))
        mirrorPath.move(to: CGPoint(x: rect.maxX, y:   rect.maxY))
        path.append(mirrorPath)
        path.close()
        path.apply(CGAffineTransform.identity.translatedBy(x: rect.width/16, y: rect.height/4))
        return path
    }
    
    private func pathForOval(inside rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let ovalRadius = rect.height/2
        
        let ovalTopLeftPoint = CGPoint(x: rect.minX+ovalRadius, y: rect.minY)
        let ovalTopRightPoint = CGPoint(x: rect.maxX-ovalRadius, y: rect.minY)
        let ovalBotLeftPoint = CGPoint(x: ovalTopLeftPoint.x, y: rect.maxY)
        let ovalMiddleRightArcPoint = CGPoint(x: ovalTopRightPoint.x, y: rect.midY)
        let ovalMiddleLeftArcPoint = CGPoint(x: ovalTopLeftPoint.x, y: rect.midY)
        
        path.move(to: ovalTopLeftPoint)
        path.addLine(to: ovalTopRightPoint)
        path.addArc(withCenter: ovalMiddleRightArcPoint, radius: ovalRadius, startAngle: CGFloat.pi*3/2, endAngle: CGFloat.pi/2, clockwise: true)
        path.addLine(to: ovalBotLeftPoint)
        path.addArc(withCenter: ovalMiddleLeftArcPoint, radius: ovalRadius, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi*3/2, clockwise: true)
        path.close()
        return path
    }
    //==Bezzier Paths end==
    
    //==Sizes start==
    private var drawRect: CGRect {
        return bounds.insetBy(dx: bounds.size.width * InsideCardRatios.marginXRation, dy: bounds.size.height * InsideCardRatios.marginYRation)
    }
    
    private var symbolsMargin : CGFloat {
        return drawRect.size.height * InsideCardRatios.marginBetweenSymbolsRation
    }
    
    private var symbolRectHeight : CGFloat {
        return drawRect.size.height * InsideCardRatios.symbolHeightRatio
    }
    
    private var symbolRectHeightWithMargin: CGFloat{
        return symbolRectHeight + symbolsMargin
    }
    
    private struct InsideCardRatios{
        static let marginXRation : CGFloat = 0.1
        static let marginYRation : CGFloat = 0.1
        static let marginBetweenSymbolsRation : CGFloat = 0.1
        static let symbolHeightRatio : CGFloat = 0.3
        static let ovalMarginRatioX : CGFloat = 0.2
        static let ovalMarginRatioY : CGFloat = 0.3
        static let ovalCurveMarginRatioX : CGFloat = 0.15
    }
    //==Sizes end==
    
    //==Contstants start==
    private struct DefaultValues {
        struct Colors {
            static let first = UIColor.blue
            static let second = UIColor.red
            static let third = UIColor.black
        }
        
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 1.0
        static let borderWidthSelected: CGFloat = 3.0
        static let borderColor: UIColor   = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        static let borderColorSet: UIColor   = #colorLiteral(red: 0.7955725047, green: 0.9408726702, blue: 1, alpha: 1)
        static let backgrounfColor: CGColor   = #colorLiteral(red: 0.8611123809, green: 0.878238342, blue: 0.7390054341, alpha: 0.8309859155)
        static let hintColor: CGColor   = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        static let symbolStrokeWidth: CGFloat = 6.0
        static let selectedColor: CGColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        static let setColor: CGColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        static let defaultBorderColor: CGColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    }
}


