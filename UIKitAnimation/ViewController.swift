//
//  ViewController.swift
//  UIKitAnimation
//
//  Created by Alb on 7/1/16.
//  Copyright © 2016 10gic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boxView: UIView!

    let tapGesture = UITapGestureRecognizer()
    let pangGesture = UIPanGestureRecognizer()

    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()

        boxView.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(pangGesture)

        tapGesture.addTarget(self, action: #selector(self.boxWasTapped))
        pangGesture.addTarget(self, action: #selector(self.boxWasPanned))

        let timing = UICubicTimingParameters(animationCurve: .easeOut)

        // Custom timing graphs contructor . ^CompletionPercentage : > TimePercentage graph rapresentation
//        let curve = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.0, y: 1.0),
//                                            controlPoint2: CGPoint(x: 1.0, y: 0.0)) // SpeedIn-SpeedOut

        //Custom timing constructors
//        let timing UISpringTimingParameters(dampingRatio: <#T##CGFloat#>, initialVelocity: <#T##CGVector#>)
//        let timing = UISpringTimingParameters(mass: <#T##CGFloat#>, stiffness: <#T##CGFloat#>, damping: <#T##CGFloat#>, initialVelocity: <#T##CGVector#>) //ignores time duration passed. It computes based on other parameters that are given.

        animator = UIViewPropertyAnimator(duration: 2.0, timingParameters: timing)

        animator.addAnimations { 
            self.boxView.center = CGPoint(x: self.boxView.center.x + 100, y: self.boxView.center.y)
            self.boxView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            self.boxView.backgroundColor = UIColor.blue()
        }

        animator.addCompletion { _ in
            self.boxView.backgroundColor = UIColor.blue()
        }

        animator.startAnimation()

//        animator.stopAnimation(false) // if true copmetion is not called
//        animator.finishAnimation(at: .end) // snaping to relative positions
    }

    func boxWasPanned(_ gesture: UIPanGestureRecognizer) {
        let gesturePoint = gesture.location(in: self.view)
        let percentage = min(gesturePoint.x / 100, 1.0) // 100 is the hardcoded value of the box moving through x axis
        let fraction = max(0.0, percentage) // prevent negative values

        animator.fractionComplete = fraction
    }

    func boxWasTapped() {
        switch animator.state {
        case .active:
            if animator.isRunning {
                reverseBoxAnimation()
            } else {
                reverseBoxAnimation()
            }

        case .stopped:
            animator.continueAnimation(withTimingParameters: .none, durationFactor: 0.4)
            break
    
        case .inactive:
            fallthrough
        default:
            break
        }
    }

    func reverseBoxAnimation() {
        animator.pauseAnimation()
        animator.isReversed = true
        animator.startAnimation()
    }
}

