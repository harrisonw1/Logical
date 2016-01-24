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
    
    let size = CGSize(width: 80, height: 80)


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
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
        
        self.graphView.frame = self.view.frame
        self.view.backgroundColor = UIColor.darkTextColor()
        self.view.addSubview(self.graphView)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

