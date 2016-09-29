//
//  LineView.swift
//  TouchCircleDemo
//
//  Created by Rebecca Siow on 9/24/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    var lineStart = CGPointZero         //Coordinate of the line's starting point
    var lineEnd = CGPointZero           //Coordinate of the line's ending point
    var linePath = [CGPoint]()          //Array of line's coordinates
    var lineThickness: CGFloat = 1.0    //Thickness of line width
    var lineColor: UIColor = UIColor.blackColor()
    
    func updateLine(startCoord: CGPoint, endCoord: CGPoint, lineThicknessVal: CGFloat){
        
        print("updateLine from this: x:(\(lineStart), y:\(lineEnd))")
        print(" to this: x:\(startCoord), y:\(endCoord))")
        
        lineStart = startCoord
        lineEnd = endCoord
        linePath.append(endCoord)
        lineThickness = lineThicknessVal
        
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect){
        
        drawDot(lineStart)
        
        if linePath.count > 2 {
            
            let path = createQuadPath(linePath)
            
            path.moveToPoint(lineStart)
            path.closePath()
            
            lineColor.set()
            path.lineWidth = lineThickness
            path.stroke()
            
            print("drawRect from point (\(lineStart) to this \(lineEnd))")
            print("line width: \(path.lineWidth)")
            
        }
        
        print("line end: \(lineEnd)")
        drawDot(lineEnd)
        
    }
    
    func drawDot(dotAtPoint: CGPoint){
        
        lineColor.setFill()
        let path = UIBezierPath()
        path.addArcWithCenter(dotAtPoint, radius: lineThickness/2.0, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        path.fill()
        
    }
    
    /**
     
     Methods for smoothing out the bezier path for the line.
     
     **/
    
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
    
}
