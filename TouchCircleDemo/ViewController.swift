//
//  ViewController.swift
//  TouchCircleDemo
//
//  Created by Rebecca Siow on 9/21/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//


//Navigation Controller: Editor -> Embed in -> Navigation Controller, add bar button item from the menu

import UIKit

class ViewController: UIViewController {
    
    //keep track of first point of touch from touchesBegan to use the touch from touchesMoved to resize the circle
    
    var currCircleCenter = CGPointZero
    var currCircle: CircleView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        //let myRect = CGRect(x: touch.x, y: touch.y, width: 80, height: 80)
        let myRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        //TouchCircle is our new Cocoa Touch Class
        //let myCircleView = CircleView(frame: myRect)
        currCircle = CircleView(frame: myRect)
        currCircle!.backgroundColor = UIColor.clearColor()
        currCircleCenter = touch
        
        self.view.addSubview(currCircle!)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchPoint = (touches.first)!.locationInView(self.view) as CGPoint
        print("Coordinates of touchesMoved point: \(touchPoint)")
        let distance = sqrt(pow(touchPoint.y - currCircleCenter.y, 2) + pow(touchPoint.x - currCircleCenter.x, 2))
        
        currCircle?.updateCircle(currCircleCenter,radius: distance)
        
        
        
    }
}

