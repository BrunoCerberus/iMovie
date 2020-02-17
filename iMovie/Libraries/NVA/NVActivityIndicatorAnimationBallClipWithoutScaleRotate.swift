//
//  NVActivityIndicatorAnimationBallClipWithoutScaleRotate.swift
//  iMovie

//  Created by bruno on 05/12/19.
//  Copyright © 2019 bruno. All rights reserved.
//

import UIKit

class NVActivityIndicatorAnimationBallClipWithoutScaleRotate: NVActivityIndicatorAnimationDelegate {

    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let duration: CFTimeInterval = 0.75

        // Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")

        rotateAnimation.keyTimes = [0, 0.5, 1]
        rotateAnimation.values = [0, Double.pi, 2 * Double.pi]

        // Animation
        let animation = CAAnimationGroup()

        animation.animations = [rotateAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        // Draw circle
        let circle = NVActivityIndicatorShape.ringThirdFour.layerWith(size: CGSize(width: size.width, height: size.height), color: color)
        let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                           y: (layer.bounds.size.height - size.height) / 2,
                           width: size.width,
                           height: size.height)

        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}
