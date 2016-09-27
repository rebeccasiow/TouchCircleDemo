//
//  ViewController.swift
//  TouchCircleDemo
//
//  Created by Rebecca Siow on 9/21/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//


//Navigation Controller: Editor -> Embed in -> Navigation Controller, add bar button item from the menu

/**
 [40 points] Users can draw continuous lines by tapping and dragging.
 [10 points] Lines drawn must be smooth (no jagged edges).
 [5 points] Users can “undo” to erase the last line drawn.
 [5 points] Users can selected from multiple (at least 5) color options.
 [5 points] There is a slider to adjust the thickness of drawn lines.
 [10 points] Single taps result in dots.
 [5 points] Users can easily erase all lines on the page.
 [20 points] Creative portion: Add 2 other small features (ability to add a title, users can change
 the background color of the page, there is a button that draws a perfect circle, etc.)

 **/

import UIKit

class ViewController: UIViewController {
    
    //keep track of first point of touch from touchesBegan to use the touch from touchesMoved to resize the circle
    
    @IBOutlet weak var clearViewButton: UIBarButtonItem!
    
    @IBOutlet weak var undoButton: UIBarButtonItem!
    
    @IBAction func undoLast(sender: UIBarButtonItem) {
        
        self.undoButton.enabled = true
        self.view.clearsContextBeforeDrawing = true
        
        print("undo called")
        let lastThing = self.view.subviews.last
        lastThing?.removeFromSuperview()
        
        
    }
    @IBAction func clearView(sender: UIBarButtonItem) {
        //view.setNeedsDisplay()
        //clearViewButton.accessibilityActivate()
        self.clearViewButton.enabled = true;
        self.view.clearsContextBeforeDrawing = true
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        
    }
    
    var currCircle: CircleView? = nil
    var currCircleCenter = CGPointZero
    
    var startCoordLine = CGPointZero
    var currLine: LineView? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    
        clearViewButton.accessibilityActivate()
        
        navigationItem.leftBarButtonItem = clearViewButton
        navigationItem.rightBarButtonItem = undoButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Idea: Enlarge radius of a circle on touch and drag out. 
     Use: touchesBegan and touchesMoved(called when the finger is on the screen and moving, keeps track of the latest touch)
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //locates touch as a coordinate from the set of UITouches, needs to be unwrapped
        let touch = (touches.first)!.locationInView(self.view) as CGPoint
        print("Coordinates of touchesBegan point: \(touch)")

        startCoordLine = touch
        
        let myRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        //let dot = CGRect(x: touch.x, y: touch.y, width: 1, height: 1)
        //let dotView = UIView(frame:dot)
        //self.view.addSubview()
        
        
        
        currLine = LineView(frame: myRect)
        currLine?.backgroundColor = UIColor.clearColor()
        currLine?.lineStart = touch
        currLine?.lineEnd = touch
        
        
        
        
        self.view.addSubview(currLine!)
        
        //TouchCircle is our new Cocoa Touch Class
        /**
        currCircle = CircleView(frame: myRect)
        currCircle!.backgroundColor = UIColor.clearColor()
        currCircleCenter = touch
 
        self.view.addSubview(currCircle!)
        **/
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touchPoint = (touches.first)!.locationInView(self.view) as CGPoint
        print("Coordinates of touchesMoved point: \(touchPoint)")
        
        currLine?.updateLine(startCoordLine, endCoord: touchPoint)
        
        //let distance = sqrt(pow(touchPoint.y - currCircleCenter.y, 2) + pow(touchPoint.x - currCircleCenter.x, 2))
        
        //currCircle?.updateCircle(currCircleCenter,radius: distance)
        
    }
    
    
}

