//
//  CircleView.swift
//  TouchCircleDemo
//
//  Created by Rebecca Siow on 9/21/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    var arcCenter = CGPointZero
    var arcRadius = CGFloat()
    
    func updateCircle(center: CGPoint, radius: CGFloat){
        arcCenter = center
        arcRadius = radius
        
        //redraws the entire bounds frame of the class CircleView - like calling CircleView(frame: center, radius)
        setNeedsDisplay()
        
    }
    
    //only override drawRect for custom drawing
    //empty implementation affects performance during animations
    
    override func drawRect(rect: CGRect){
        UIColor.greenColor().setFill()
        
        let path = UIBezierPath()
        
        path.addArcWithCenter(arcCenter, radius: arcRadius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        path.fill()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
