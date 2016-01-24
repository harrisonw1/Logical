//
//  DetailViewController.swift
//  Logical
//
//  Created by Ethan Gill on 1/23/16.
//  Copyright © 2016 Ethan Gill. All rights reserved.
//

import UIKit

import GraphView

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var graphView: GraphView!
    @IBOutlet weak var canView: CanvasView!
    var canvasView: CanvasView {
        return canView as CanvasView
    }
    
    let size = CGSize(width: 80, height: 80)
    var circleGestureRecognizer:CircleGestureRecognizer?
    let pencilGestureRecognizer = PencilGestureRecognizer()
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        //        if let detail = self.detailItem {
        //            if let label = self.detailDescriptionLabel {
        //                label.text = detail.description
        //            }
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let red: UIView = RoundedView()
        red.backgroundColor = .redColor()
        red.frame.size = size
        
        let blue: UIView = RoundedView()
        blue.backgroundColor = .blueColor()
        blue.frame.size = size
        
        let green: UIView = RoundedView()
        green.backgroundColor = .greenColor()
        green.frame.size = size
        
        let yellow: UIView = RoundedView()
        yellow.backgroundColor = .yellowColor()
        yellow.frame.size = size
        
        let purple: UIView = RoundedView()
        purple.backgroundColor = .purpleColor()
        purple.frame.size = size
        
        let brown: UIView = RoundedView()
        brown.backgroundColor = .brownColor()
        brown.frame.size = size
        
        let orange: UIView = RoundedView()
        
        orange.backgroundColor = .orangeColor()
        orange.frame.size = size
        
        let gray: UIView = RoundedView()
        gray.backgroundColor = .grayColor()
        gray.frame.size = size
        
        self.graphView = GraphView(graph: Graph(nodes: [red, blue ,green ,yellow ,purple ,brown ,orange ,gray], edges: [(red,blue), (blue, green), (green, yellow), (purple, brown), (brown, red), (red, orange), (orange, gray), (yellow, gray)]))
        // self.graphView.graph.addNode("Hello")
        //self.view.backgroundColor = UIColor.darkTextColor()
        self.graphView.frame = self.view.frame
        self.graphView.panGestureRecognizer.delegate = self
        
        self.view.addSubview(self.graphView)
        self.graphView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor)
        self.graphView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        self.graphView.topAnchor.constraintEqualToAnchor(view.topAnchor)
        self.graphView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        
        
        self.canvasView.backgroundColor = UIColor.clearColor()
        self.canvasView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor)
        self.canvasView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        self.canvasView.topAnchor.constraintEqualToAnchor(view.topAnchor)
        self.canvasView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        self.canvasView.userInteractionEnabled = false
        self.view.addSubview(canvasView)
        canvasView.addSubview(reticleView)
        
        
        //the circle gesture recognizer
        self.circleGestureRecognizer = CircleGestureRecognizer(target: self, action: "circled:")
        self.circleGestureRecognizer!.delegate = self
        self.view.addGestureRecognizer(circleGestureRecognizer!)
        
        self.pencilGestureRecognizer.delegate = self
        self.pencilGestureRecognizer.pencilDelegate = self
        self.view.addGestureRecognizer(pencilGestureRecognizer)
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var visualizeAzimuth = false
    
    let reticleView: ReticleView = {
        let view = ReticleView(frame: CGRect.null)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidden = true
        
        return view
    }()
    
//    // MARK: Touch Handling
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if touches.first?.type == .Stylus{
//            self.canvasView.drawTouches(touches, withEvent: event)
//            
//            if visualizeAzimuth {
//                for touch in touches {
//                    if touch.type == .Stylus {
//                        reticleView.hidden = false
//                        updateReticleViewWithTouch(touch, event: event)
//                    }
//                }
//            }
//        } else {
//            super.touchesBegan(touches, withEvent: event)
//        }
//    }
//    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if touches.first?.type == .Stylus{
//        canvasView.drawTouches(touches, withEvent: event)
//        
//        if visualizeAzimuth {
//            for touch in touches {
//                if touch.type == .Stylus {
//                    updateReticleViewWithTouch(touch, event: event)
//                    
//                    // Use the last predicted touch to update the reticle.
//                    guard let predictedTouch = event?.predictedTouchesForTouch(touch)?.last else { return }
//                    
//                    updateReticleViewWithTouch(predictedTouch, event: event, isPredicted: true)
//                }
//            }
//            }
//        } else {
//            super.touchesMoved(touches, withEvent: event)
//        }
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if touches.first?.type == .Stylus{
//            canvasView.drawTouches(touches, withEvent: event)
//            canvasView.endTouches(touches, cancel: false)
//            
//            if visualizeAzimuth {
//                for touch in touches {
//                    if touch.type == .Stylus {
//                        reticleView.hidden = true
//                    }
//                }
//            }
//        }
//        super.touchesEnded(touches, withEvent: event)
//    }
//    
//    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
//        guard let touches = touches else { return }
//        if touches.first?.type == .Stylus {
//            canvasView.endTouches(touches, cancel: true)
//            
//            if visualizeAzimuth {
//                for touch in touches {
//                    if touch.type == .Stylus {
//                        reticleView.hidden = true
//                    }
//                }
//            }
//        }
//        super.touchesCancelled(touches, withEvent: event)
//    }
    
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
        canvasView.updateEstimatedPropertiesForTouches(touches)
    }
    
    // MARK: Actions
    
    //    @IBAction func clearView(sender: UIBarButtonItem) {
    //        canvasView.clear()
    //    }
    //
    //    @IBAction func toggleDebugDrawing(sender: UIButton) {
    //        canvasView.isDebuggingEnabled = !canvasView.isDebuggingEnabled
    //        visualizeAzimuth = !visualizeAzimuth
    //        sender.selected = canvasView.isDebuggingEnabled
    //    }
    //
    //    @IBAction func toggleUsePreciseLocations(sender: UIButton) {
    //        canvasView.usePreciseLocations = !canvasView.usePreciseLocations
    //        sender.selected = canvasView.usePreciseLocations
    //    }
    
    // MARK: Rotation
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.LandscapeLeft, .LandscapeRight]
    }
    
    // MARK: Convenience
    
    func updateReticleViewWithTouch(touch: UITouch?, event: UIEvent?, isPredicted: Bool = false) {
        guard let touch = touch where touch.type == .Stylus else { return }
        
        reticleView.predictedDotLayer.hidden = !isPredicted
        reticleView.predictedLineLayer.hidden = !isPredicted
        
        let azimuthAngle = touch.azimuthAngleInView(view)
        let azimuthUnitVector = touch.azimuthUnitVectorInView(view)
        let altitudeAngle = touch.altitudeAngle
        
        if isPredicted {
            reticleView.predictedAzimuthAngle = azimuthAngle
            reticleView.predictedAzimuthUnitVector = azimuthUnitVector
            reticleView.predictedAltitudeAngle = altitudeAngle
        }
        else {
            let location = touch.preciseLocationInView(view)
            reticleView.center = location
            reticleView.actualAzimuthAngle = azimuthAngle
            reticleView.actualAzimuthUnitVector = azimuthUnitVector
            reticleView.actualAltitudeAngle = altitudeAngle
        }
    }
    
    func circled(c: CircleGestureRecognizer) {
        if c.state == .Ended {
            //findCircledView(c.fitResult.center)
            if c.isCircle == true {
            }
        }
        if c.state == .Began {
            //circlerDrawer.clear()
            //goToNextTimer?.invalidate()
        }
        if c.state == .Changed {
            //circlerDrawer.updatePath(c.path)
        }
        if c.state == .Ended || c.state == .Failed || c.state == .Cancelled {
            if c.isCircle {
                self.createNewNode(c.fitResult)
            }
            if c.isCircle == false{
            self.canvasView.clear()
            }
        }
    }
    
    func createNewNode(fit:CircleResult){
        let newView = RoundedView()
        //no size yet
        newView.frame.size = CGSize(width: 40, height: 40)
        newView.alpha = 0.0
        newView.frame.origin.x = fit.center.x - fit.radius
        newView.frame.origin.y = fit.center.y - fit.radius
        newView.backgroundColor = UIColor.purpleColor()
        self.graphView.graph.addNode(newView)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.05, initialSpringVelocity: 0.1, options: [], animations: {
            newView.frame.size = CGSize(width: 80, height: 80)
            newView.alpha = 1.0
            }, completion: {
                success in
                print("YAY")
        })
    }
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer == self.circleGestureRecognizer {
            return touch.type == .Stylus
        } else if gestureRecognizer == self.pencilGestureRecognizer {
            return touch.type == .Stylus
        } else {
            //everything else
            return touch.type != .Stylus
        }
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //TODO: this should depend on if it's a pencil GR or not
        //ie pencil GR should with other pencil GR, but not with non-pencil GR
        return true
    }
}

//extension DetailViewController: CircleGestureRecognizerDelegate {
//    func circleDetected(fit:CircleResult) {
//        
//        self.canvasView.clear()
//    }
//    
//    func lineDetected() {
//        self.canvasView.clear()
//    }
//}

extension DetailViewController: PencilGestureRecognizerDelegate {
    func drawTouches(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.canvasView.drawTouches(touches, withEvent: event)
    }
    func endTouches(touches: Set<UITouch>, cancel: Bool) {
        self.canvasView.endTouches(touches, cancel: cancel)
    }
    func updateEstimatedPropertiesForTouches(touches: Set<NSObject>) {
        self.canvasView.updateEstimatedPropertiesForTouches(touches)
    }
}

