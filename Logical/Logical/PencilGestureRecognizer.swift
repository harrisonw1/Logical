//
//  PencilGestureRecognizer.swift
//  Logical
//
//  Created by Ethan Gill on 1/24/16.
//  Copyright © 2016 Ethan Gill. All rights reserved.
//

import UIKit

protocol PencilGestureRecognizerDelegate: class {
    func drawTouches(touches: Set<UITouch>, withEvent event:UIEvent?)
    func endTouches(touches: Set<UITouch>, cancel:Bool)
    func updateEstimatedPropertiesForTouches(touches: Set<NSObject>)
}

class PencilGestureRecognizer: UIGestureRecognizer {
    
    weak var pencilDelegate: PencilGestureRecognizerDelegate?
    
    // MARK: Touch Handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.pencilDelegate?.drawTouches(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.pencilDelegate?.drawTouches(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.pencilDelegate?.drawTouches(touches, withEvent: event)
        self.pencilDelegate?.endTouches(touches, cancel: false)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touches = touches else { return }
        self.pencilDelegate?.endTouches(touches, cancel: true)
    }
    
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
        self.pencilDelegate?.updateEstimatedPropertiesForTouches(touches)
    }
    
    
}
