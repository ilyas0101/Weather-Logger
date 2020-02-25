//
//  SplashAnimation.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

public typealias AnimationCompletion = () -> Void
public typealias AnimationExecution = () -> Void

extension SplashView {
    public func startAnimation(_ completion: AnimationCompletion? = nil) {
        switch animationType {
        case .twitter:
            playTwitterAnimation(completion)
            
        case .heartBeat:
            playHeartBeatAnimation(completion)
        }
    }
    
    public func playTwitterAnimation(_ completion: AnimationCompletion? = nil) {
        if let imageView = self.imageView {
            let shrinkDuration: TimeInterval = duration * 0.3
            
            UIView.animate(
                withDuration: shrinkDuration,
                delay: delay,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 10,
                options: UIView.AnimationOptions(),
                animations: {
                    let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                    imageView.transform = scaleTransform
            }, completion: { _ in
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    public func playZoomOutAnimation(_ completion: AnimationCompletion? = nil) {
        if let imageView =  imageView {
            let growDuration: TimeInterval = duration * 0.3
            
            UIView.animate(withDuration: growDuration, animations: {
                imageView.transform = self.getZoomOutTranform()
                self.alpha = 0
                
            }, completion: { _ in
                self.removeFromSuperview()
                completion?()
            })
        }
    }
    
    public func playHeartBeatAnimation(_ completion: AnimationCompletion? = nil) {
        if let imageView = self.imageView {
            let popForce = 1.5
            
            animateLayer({
                let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                animation.values = [0, 0.1 * popForce, 0.015 * popForce, 0.2 * popForce, 0]
                animation.keyTimes = [0, 0.25, 0.50, 0.75, 1]
                animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                animation.duration = CFTimeInterval(self.duration/2)
                animation.isAdditive = true
                animation.repeatCount = Float(minimumBeats > 0 ? minimumBeats : 1)
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/2)
                imageView.layer.add(animation, forKey: "pop")
            }, completion: { [weak self] in
                if self?.heartAttack ?? true {
                    self?.playZoomOutAnimation(completion)
                } else {
                    self?.playHeartBeatAnimation(completion)
                }
            })
        }
    }
    
    public func finishHeartBeatAnimation() {
        self.heartAttack = true
    }
    
    fileprivate func getZoomOutTranform() -> CGAffineTransform {
        let zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 20, y: 20)
        return zoomOutTranform
    }
    
    fileprivate func animateLayer(_ animation: AnimationExecution, completion: AnimationCompletion? = nil) {
        
        CATransaction.begin()
        if let completion = completion {
            CATransaction.setCompletionBlock { completion() }
        }
        animation()
        CATransaction.commit()
    }
}
