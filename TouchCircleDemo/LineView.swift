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
    var linePath = [CGPoint]()
    
    func updateLine(startCoord: CGPoint, endCoord: CGPoint){
        
        //printing the previous point, 
        print("updateLine from this: x:(\(lineStart), y:\(lineEnd))")
        //changing to this point
        print(" to this: x:\(startCoord), y:\(endCoord))")
        
        lineStart = startCoord
        lineEnd = endCoord
        linePath.append(endCoord)
        
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect){
        
        if linePath.count > 2 {
            let path = createQuadPath(linePath)
            print("drawRect from point (\(lineStart) to this \(lineEnd))")
            //let path = createQuadPath(linePath)
            
            path.moveToPoint(lineStart)
            //path.addLineToPoint(lineEnd)
            path.closePath()
            
            UIColor.blueColor().set()
            path.stroke()
            //path.fill()
        }
        else{
        
        }
    }
    
    
    private func findMidpoint(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        let midPoint:CGPoint = CGPointMake((firstPoint.x + secondPoint.x)/2.0, (firstPoint.y + secondPoint.y)/2.0)
        return midPoint
    }
    
    func createQuadPath(arrayOfPoints: [CGPoint]) -> UIBezierPath {
        let newPath = UIBezierPath()
        let firstLocation = arrayOfPoints[0]
        newPath.moveToPoint(firstLocation)
        let secondLocation = arrayOfPoints[1]
        let firstMidpoint = findMidpoint(firstLocation, secondPoint: secondLocation)
        newPath.addLineToPoint(firstMidpoint)
        for index in 1 ..< arrayOfPoints.count-1 {
            let currentLocation = arrayOfPoints[index]
            let nextLocation = arrayOfPoints[index + 1]
            let midpoint = findMidpoint(currentLocation, secondPoint: nextLocation)
            newPath.addQuadCurveToPoint(midpoint, controlPoint: currentLocation)
        }
        let lastLocation = arrayOfPoints.last
        newPath.addLineToPoint(lastLocation!)
        return newPath
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
