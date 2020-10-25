//
//  HoverView.swift
//  Presentation
//
//  Created by masaki hasegawa on 2018/06/18.
//  Copyright © 2018年 andfactory. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol HoverViewDelegate: class {
    func didTouchDown()
    func didTouchCancel()
    func didTouchUpInside()
    func didTouchUpInside(sender: HoverView)
}

extension HoverViewDelegate {
    func didTouchDown() {}
    func didTouchCancel() {}
    func didTouchUpInside() {}
    func didTouchUpInside(sender: HoverView) {}
}

class HoverView: UIView {
    
    var didTouchDownObservable = PublishRelay<Void>()
    var didTouchCancelObservable = PublishRelay<Void>()
    var didTouchUpInsideObservable = PublishRelay<Void>()
    var didTouchUpInsideSelfObservable = PublishRelay<HoverView>()

    // defaultはalphaもscaleもアニメーション対象
    @IBInspectable var needAlphaAnimate     : Bool = true
    @IBInspectable var needScaleAnimate     : Bool = false
    @IBInspectable var needHighlightAnimate : Bool = false
    @IBInspectable var normalBackgroundColor: UIColor = .clear {
        willSet {
            self.backgroundColor = newValue
        }
    }
    @IBInspectable var highlightBackgroundColor: UIColor = #colorLiteral(red: 0.831372549, green: 0.831372549, blue: 0.831372549, alpha: 0.2006367723)
    
    private var touchDown = false
    weak var delegate: HoverViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.isExclusiveTouch = true
        self.delegate = self
    }
}

extension HoverView: HoverViewDelegate {
    
    func didTouchDown() {
        self.didTouchDownObservable.accept(())
    }
    
    func didTouchCancel() {
        self.didTouchCancelObservable.accept(())
    }
    
    func didTouchUpInside() {
        self.didTouchUpInsideObservable.accept(())
    }
    
    func didTouchUpInside(sender: HoverView) {
        self.didTouchUpInsideSelfObservable.accept(sender)
    }
}

// MARK: - touch
extension HoverView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchDown = true
        self.startForwardAnimate()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.touchDown {
            return
        }
        if let touch = touches.first {
            let point = convert(touch.location(in: self), to: self)
            if point.x < 0 || point.x > self.bounds.size.width || point.y < 0 || point.y > self.bounds.size.height {
                self.endForwardAnimate()
                return
            }
            else {
                self.startBackAnimate()
            }
            self.touchDown = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.touchDown {
            return
        }
        
        self.endForwardAnimate()
        self.touchDown = false
    }
}

// MARK: - animation
extension HoverView {
    
    private func startForwardAnimate() {
        self.delegate?.didTouchDown()
        
        UIView.animate(
            withDuration: 0.1,
            animations: {
                if self.needAlphaAnimate {
                    self.alpha = 0.6
                }
                if self.needScaleAnimate {
                    self.transform = self.transform.scaledBy(x: 0.9, y: 0.9)
                }
                if self.needHighlightAnimate {
                    self.backgroundColor = self.highlightBackgroundColor
                }
        })
    }
    
    private func endForwardAnimate() {
        self.delegate?.didTouchCancel()
        
        UIView.animate(
            withDuration: 0.1,
            animations: {
                if self.needAlphaAnimate {
                    self.alpha = 1.0
                }
                if self.needScaleAnimate {
                    self.transform = .identity
                }
                if self.needHighlightAnimate {
                    self.backgroundColor = self.normalBackgroundColor
                }
        })
    }
    
    private func startBackAnimate() {
        self.delegate?.didTouchUpInside()
        self.delegate?.didTouchUpInside(sender: self)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                if self.needAlphaAnimate {
                    self.alpha     = 1.0
                }
                if self.needScaleAnimate {
                    self.transform = self.transform.scaledBy(x: 1.3, y: 1.3)
                }
                if self.needHighlightAnimate {
                    self.backgroundColor = self.normalBackgroundColor
                }
        },  completion: { _ in
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    if self.needScaleAnimate {
                        self.transform = .identity
                    }
            },  completion: nil)
        })
    }
}
