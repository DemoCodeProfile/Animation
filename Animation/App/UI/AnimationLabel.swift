//
//  AnimationLabel.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.
//

import UIKit

class AnimationLabel: UIView {
    
    struct Constants {
        static let duration: Double = 0.4
        static let coefficent: Double = 0.1
    }
    
    private struct AnimationChar {
        let duration: TimeInterval
        let delay: TimeInterval
        let char: String
        weak var view: UILabel?
        let finalFrame: CGRect
    }
    
    enum AlignVerticalLabel {
        case top
        case center
        case bottom
        
        func offsetY(heightLabel: CGFloat, superViewFrame: CGRect) -> CGFloat {
            let height = superViewFrame.height
            let freeSpace = height - heightLabel
            switch self {
            case .top:
                return 0
            case .center:
                return freeSpace >= 0 ? freeSpace / 2 : 0
            case .bottom:
                return freeSpace >= 0 ? freeSpace : 0
            }
        }
    }
    
    enum AlignHorizontalLabel {
        case left
        case center
        case right
        
        func offsetX(widthLabel: CGFloat, superViewFrame: CGRect) -> CGFloat {
            let width = superViewFrame.width
            let freeSpace = width - widthLabel
            switch self {
            case .left:
                return 0
            case .center:
                return freeSpace >= 0 ? freeSpace / 2 : 0
            case .right:
                return freeSpace >= 0 ? freeSpace : 0
            }
        }
    }
    
    struct AnimationLabelStyle {
        let alignHorizontal: AlignHorizontalLabel
        let alignVertical: AlignVerticalLabel
        
        init(alignHorizontal: AlignHorizontalLabel = .center, alignVertical: AlignVerticalLabel = .center) {
            self.alignHorizontal = alignHorizontal
            self.alignVertical = alignVertical
        }
    }
    
    var text: String
    private var halfFontHeight: Double
    private var font: UIFont
    private var chars: [Character] = []
    private var style: AnimationLabelStyle
    
    private var widthCommon: CGFloat = 0.0
    private var animationChars: [AnimationChar] = []
    
    init(text: String, font: UIFont, style: AnimationLabelStyle = AnimationLabelStyle()) {
        self.text = text
        self.font = font
        self.halfFontHeight = Double(text.heightOfString(usingFont: font))
        self.style = style
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateLabel() {
        resetAnimationLabel()
        configureView()
        let allTime = (animationChars.first?.delay ?? Constants.duration) + Constants.duration
        animationChars.forEach { animationChar in
            circleAnimation(animationChar: animationChar, allTime: allTime)
        }
    }
    
    private func resetAnimationLabel() {
        animationChars.forEach {
            $0.view?.layer.removeAllAnimations()
            $0.view?.removeFromSuperview()
        }
        widthCommon = style.alignHorizontal.offsetX(
            widthLabel: text.widthOfString(usingFont: font),
            superViewFrame: bounds
        )
        chars = text.characterArray
        animationChars = []
    }
    
    private func configureView() {
        let allTime = Double(chars.count) * Constants.duration
        for (index, symbol) in chars.enumerated() {
            let node = UILabel()
            node.font = font
            let symbol = String(symbol)
            let width = symbol.widthOfString(usingFont: node.font)
            let height = symbol.heightOfString(usingFont: node.font)
            node.frame = CGRect(x: widthCommon, y: style.alignVertical.offsetY(heightLabel: height, superViewFrame: bounds), width: CGFloat(width), height: height)
            let animationChar = AnimationChar(
                duration: Constants.duration,
                delay: (allTime - TimeInterval(Double(index) * Constants.duration)) * Constants.coefficent,
                char: symbol,
                view: node,
                finalFrame: node.frame
            )
            animationChars.append(animationChar)
            node.text = animationChar.char
            widthCommon += width
            addSubview(node)
        }
    }
    
    private func circleAnimation(animationChar: AnimationChar, allTime: Double) {
        animationChar.view?.transform = CGAffineTransform(scaleX: 0, y: 0)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            animationChar.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
            animationChar.view?.frame = animationChar.finalFrame
        }
        let minRadius = CGFloat(halfFontHeight * 3)
        let maxRadius = CGFloat(halfFontHeight * 4)
        let radius = CGFloat.random(in: minRadius...maxRadius)
        let viewCenter = animationChar.view?.center ?? .zero
        let arcCenter = CGPoint(x: viewCenter.x - radius, y: viewCenter.y)
        let circlePath = UIBezierPath(
            arcCenter: arcCenter,
            radius: radius,
            startAngle: .pi,
            endAngle: .pi * 2,
            clockwise: false
        )
        circlePath.addLine(
            to: CGPoint(
                x: circlePath.currentPoint.x,
                y: circlePath.currentPoint.y - CGFloat(halfFontHeight)
            )
        )
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = animationChar.duration
        positionAnimation.beginTime = animationChar.delay
        positionAnimation.path = circlePath.cgPath
        positionAnimation.fillMode = .forwards
        positionAnimation.isRemovedOnCompletion = false
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.duration = animationChar.duration
        scaleAnimation.beginTime = animationChar.delay
        scaleAnimation.fillMode = .forwards
        scaleAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = CGFloat.pi
        rotationAnimation.toValue = 0.0
        rotationAnimation.duration = animationChar.duration
        rotationAnimation.beginTime = animationChar.delay
        
        let positionLinearAnimation = CAKeyframeAnimation(keyPath: "position.y")
        positionLinearAnimation.values = [
            0.0,
            halfFontHeight,
            0.0,
            halfFontHeight / 2,
            halfFontHeight
        ]
        positionLinearAnimation.keyTimes = [0.0, 0.2, 0.5, 0.75, 1.0]
        positionLinearAnimation.duration = animationChar.duration
        positionLinearAnimation.beginTime = allTime - animationChar.duration + animationChar.delay
        positionLinearAnimation.isAdditive = true
        positionLinearAnimation.fillMode = .forwards
        positionLinearAnimation.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.duration = allTime * 2
        group.animations = [
            positionAnimation,
            scaleAnimation,
            rotationAnimation,
            positionLinearAnimation
        ]
        group.repeatCount = 1000
        group.repeatDuration = 6.0
        animationChar.view?.layer.add(group, forKey: nil)
        CATransaction.commit()
    }
}
