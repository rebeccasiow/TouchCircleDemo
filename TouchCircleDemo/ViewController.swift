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
 DONE: [5 points] Users can selected from multiple (at least 5) color options.
 DONE: [5 points] There is a slider to adjust the thickness of drawn lines.
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
    
    @IBOutlet weak var redoButton: UIBarButtonItem!
    
    
// Outlet Actions
    
    var lastThing: UIView!
    
    @IBAction func undoLast(sender: UIBarButtonItem) {
        
        self.undoButton.enabled = true
        self.view.clearsContextBeforeDrawing = true
        
        print("undo called")
        lastThing = self.view.subviews.last
        if lastThing!.frame.height == (self.view.frame.height - 100) {
            lastThing?.removeFromSuperview()
        }
        
    }
    
    @IBAction func redoLast(sender: UIBarButtonItem) {
        self.view.addSubview(lastThing)
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
    
    @IBAction func templateChange(sender: UIButton) {
        guard let templateItem = sender.titleLabel?.text else{
            return
        }
        print("template is \(templateItem)")
        
        let templateView = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-100)
        
        var myImage: NSURL
        
        switch templateItem {
        case "Bird":
            print("it is a bird")
            let myImageURL = NSURL(string: "https://s-media-cache-ak0.pinimg.com/736x/d7/19/b0/d719b0b07dda762db5c74b8fea4f036a.jpg")
            myImage = myImageURL!
            
        case "Enrique":
            let myImageURL = NSURL(string: "https://pbs.twimg.com/profile_images/667776779222781953/mLMqVpCf.jpg")
            myImage = myImageURL!
            
        case "Sheep":
            let myImageURL = NSURL(string: "https://i.imgur.com/IYuULom.jpg")
            myImage = myImageURL!
        
        case "Vicky":
            let myImageURL = NSURL(string: "https://scontent-ord1-1.xx.fbcdn.net/t31.0-8/10575284_551815004922530_3655500328147147830_o.jpg")
            myImage = myImageURL!
        
        case "Empty":
            self.view.backgroundColor = UIColor.whiteColor()
            print("empty background")
            return
        default:
            return
        }
        
        let myImageData = NSData(contentsOfURL: myImage)
        let image = UIImage(data: myImageData!)
        
        let showTemplate = UIImageView(image: image)
        showTemplate.contentMode = UIViewContentMode.ScaleAspectFit
        showTemplate.frame = templateView
        self.view.addSubview(showTemplate)
        
    }
    
    
    
// Loading the main view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = clearViewButton
        navigationItem.rightBarButtonItem = undoButton
        navigationItem.rightBarButtonItem = redoButton
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

