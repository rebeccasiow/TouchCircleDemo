//
//  LineView.swift
//  TouchCircleDemo
//
//  Created by Rebecca Siow on 9/24/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class LineView: UIView {
    var lineStart = CGPointZero
    var lineEnd = CGPointZero
    
    func updateLine(startCoord: CGPoint, endCoord: CGPoint){
        //printing the previous point, 
        print("updateLine from this: x:(\(lineStart), y:\(lineEnd))")
        //changing to this point
        print(" to this: x:\(startCoord), y:\(endCoord))")
        lineStart = startCoord
        lineEnd = endCoord
        setNeedsDisplay()
        //setneedsdisplay()
    }
    
    override func drawRect(rect: CGRect){
        print("drawRect from point (\(lineStart) to this \(lineEnd))")

        let path = UIBezierPath()
        path.moveToPoint(lineStart)
        path.addLineToPoint(lineEnd)
        path.closePath()
        
        UIColor.blueColor().set()
        path.stroke()
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
