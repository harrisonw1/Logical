//
//  LineGestureRecognizer.swift
//  Logical
//
//  Created by Ethan Gill on 1/24/16.
//  Copyright © 2016 Ethan Gill. All rights reserved.
//

import UIKit

class LineGestureRecognizer: UIGestureRecognizer {

    private var touchedPoints = [CGPoint]() // point history
    var path = CGPathCreateMutable() // running CGPath - helps with drawing
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if touches.count != 1 {
            state = .Failed
        }
        state = .Began
        
        let window = view?.window
        if let touches = touches as? Set<UITouch>, loc = touches.first?.locationInView(window) {
            CGPathMoveToPoint(path, nil, loc.x, loc.y) // start the path
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        // now that the user has stopped touching, figure out if the path was a circle
        //fitResult = fitCircle(touchedPoints)
        
        // make sure there are no points in the middle of the circle
//        let hasInside = anyPointsInTheMiddle()
//        
//        let percentOverlap = calculateBoundingOverlap()
        //isCircle = fitResult.error <= tolerance && !hasInside && percentOverlap > (1-tolerance)
        
        state = .Ended
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        // 1
        if state == .Failed {
            return
        }
        
        // 2
        let window = view?.window
        if let touches = touches as? Set<UITouch>, loc = touches.first?.locationInView(window) {
            // 3
            touchedPoints.append(loc)
            CGPathAddLineToPoint(path, nil, loc.x, loc.y)
            // 4
            state = .Changed
        }
    }
    
    override func reset() {
        super.reset()
        touchedPoints.removeAll(keepCapacity: true)
        path = CGPathCreateMutable()
  //      isCircle = false
        state = .Possible
    }

    
}
