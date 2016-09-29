//
//  ViewController.swift
//  TouchCircleDemo
//
//  Created by Rebecca Siow on 9/21/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//


//Navigation Controller: Editor -> Embed in -> Navigation Controller, add bar button item from the menu

/**
 DONE: [40 points] Users can draw continuous lines by tapping and dragging.
 DONE: [10 points] Lines drawn must be smooth (no jagged edges).
 DONE: [5 points] Users can “undo” to erase the last line drawn.
 [5 points] Users can selected from multiple (at least 5) color options.
 [5 points] There is a slider to adjust the thickness of drawn lines.
 DONE: [10 points] Single taps result in dots.
 DONE: [5 points] Users can easily erase all lines on the page.
 [20 points] Creative portion: Add 2 other small features (ability to add a title, users can change
 the background color of the page, there is a button that draws a perfect circle, etc.) 
  - redo maybe?

 **/

import UIKit

class ViewController: UIViewController {
    
// Outlets
    
    @IBOutlet weak var formatScrollView: UIScrollView!
    
    @IBOutlet weak var lineThicknessSlider: UISlider!
    
    @IBOutlet weak var clearViewButton: UIBarButtonItem!
    
    @IBOutlet weak var undoButton: UIBarButtonItem!
    
    
    
// Outlet Actions
    
    @IBAction func undoLast(sender: UIBarButtonItem) {
        
        self.undoButton.enabled = true
        self.view.clearsContextBeforeDrawing = true
        
        print("undo called")
        let lastThing = self.view.subviews.last
        if lastThing!.frame.height == (self.view.frame.height - 100) {
            lastThing?.removeFromSuperview()
        }
        
        
    }
    
    @IBAction func clearView(sender: UIBarButtonItem) {
        for view in self.view.subviews {
            if view.frame.height == (self.view.frame.height - 100) {
                view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func lineThicknessChanged(sender: UISlider) {
        print("line thickness slider value \(lineThicknessSlider.value)")
        currLineThickness = CGFloat(lineThicknessSlider.value)
    }
    
    @IBAction func colorChange(sender: ColorSelectorButton) {
        print("Color changed")
        currLineColor = sender.backgroundColor!
    }
    
    
    
// Loading the main view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = clearViewButton
        navigationItem.rightBarButtonItem = undoButton
        formatScrollView.contentSize.width = 1000
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
// Global variables to track current line format.
    
    var startCoordLine = CGPointZero
    var currLine: LineView? = nil
    var currLineThickness:CGFloat = 1.0
    var currLineColor: UIColor = UIColor.blackColor()
    
// User Interactions with the screen.
    
    /*
     touchesBegan: coordinate of first touch
     touchesMoved: called when the finger is on the screen and moving, keeps track of the latest touch
     */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        let touch = (touches.first)!.locationInView(self.view) as CGPoint
        print("Coordinates of touchesBegan point: \(touch)")
        
        // Draw only if inside Draw View.
        
        if touch.y < (self.view.frame.height - formatScrollView.frame.height) {
            
            startCoordLine = touch
            
            let drawingRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.height - formatScrollView.frame.height) )
            
            currLine = LineView(frame: drawingRect)
            currLine?.backgroundColor = UIColor.clearColor()
            
            currLine?.lineStart = touch
            currLine?.lineEnd = touch
            currLine?.lineThickness = currLineThickness
            currLine?.lineColor = currLineColor
            
            self.view.addSubview(currLine!)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touchPoint = (touches.first)!.locationInView(self.view) as CGPoint
        print("Coordinates of touchesMoved point: \(touchPoint)")
        
        if touchPoint.x >= 0 && touchPoint.y >= 0 {
            currLine?.updateLine(startCoordLine, endCoord: touchPoint, lineThicknessVal: currLineThickness)
        }
        
    }
}

