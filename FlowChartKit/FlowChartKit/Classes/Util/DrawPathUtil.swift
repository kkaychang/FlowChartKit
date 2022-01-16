//
//  DrawPathUtil.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/30.
//

import UIKit

class DrawPathUtil {
    // ㄇ型Path右往左畫
    func drawTopLineWithTwoArcFromRightToLeft(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: startPoint.y - defaultSpace)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .rightToTop))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y - radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: endPoint.x + radius , y: lastPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .topToLeft))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x, y: lastPoint.y + defaultSpace + radius)))
        return path
    }
    
    // ㄇ型Path左往右畫
    func drawTopLineWithTwoArcFromLeftToRight(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: startPoint.y - defaultSpace)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .leftToTop))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y - radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: endPoint.x - radius, y: lastPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .topToRight))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x, y: lastPoint.y + defaultSpace)))
        return path
    }
    
    // U型Path左往右畫
    func drawBottomLineWithTwoArcFromLeftToRight(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: startPoint.y + defaultSpace - radius)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .leftToDown))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: endPoint.x, y: lastPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .downToRight))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y - radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x, y: lastPoint.y - defaultSpace + radius)))
        return path
    }
    
    // U型Path右往左畫
    func drawBottomLineWithTwoArcFromRighToLeft(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: startPoint.y + defaultSpace - radius)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .rightToDown))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: endPoint.x + radius, y: lastPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .downToLeft))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y - radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x, y: lastPoint.y - defaultSpace + radius)))
        return path
    }
    
    // [型Path
    func drawLeftLineWithTwoArcFrom(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x - defaultSpace + radius, y: startPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .topToLeft))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x, y: endPoint.y - radius)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .leftToDown))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x + defaultSpace - radius, y: lastPoint.y)))
        return path
    }
    
    // ]型Path
    func drawRightLineWithTwoArcFrom(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x + defaultSpace - radius, y: startPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .topToRight))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x, y: endPoint.y - radius)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .rightToDown))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: lastPoint.x - defaultSpace + radius, y: lastPoint.y)))
        return path
    }
    
    // 直線Path
    func drawLine(from startPoint: CGPoint, to endPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
    
    // 1/4弧形Path
    func drawOneQuarterArc(point: CGPoint, radius: CGFloat, direction: PathDirection) -> UIBezierPath {
        
        var centerPoint: CGPoint
        
        switch direction {
        case .topToLeft:
            centerPoint = CGPoint(x: point.x, y: point.y + radius)
        case .topToRight:
            centerPoint = CGPoint(x: point.x, y: point.y + radius)
        case .rightToTop:
            centerPoint = CGPoint(x: point.x - radius, y: point.y)
        case .leftToTop:
            centerPoint = CGPoint(x: point.x + radius, y: point.y)
        case .leftToDown:
            centerPoint = CGPoint(x: point.x + radius, y: point.y)
        case .rightToDown:
            centerPoint = CGPoint(x: point.x - radius, y: point.y)
        case .downToLeft:
            centerPoint = CGPoint(x: point.x, y: point.y - radius)
        case .downToRight:
            centerPoint = CGPoint(x: point.x , y: point.y - radius)
        }
        
        return UIBezierPath.init(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(direction.startAngle) * .pi / 180, endAngle: CGFloat(direction.endAngle) * .pi / 180, clockwise: true)
    }
    
    // ㄣ型Path
    func drawLineTopTurnLeftAndTurnRight(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: startPoint.y + defaultSpace - radius)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .leftToDown))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: endPoint.x - radius, y: lastPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .topToRight))
        lastPoint = CGPoint(x: lastPoint.x + radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: endPoint))
        return path
    }
    
    // 水平翻轉ㄣ型Path
    func drawLineTopTurnRightAndTurnLeft(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        var lastPoint: CGPoint
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: startPoint.y + defaultSpace - radius)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .rightToDown))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: CGPoint(x: endPoint.x + radius, y: lastPoint.y)))
        lastPoint = path.currentPoint
        path.append(drawOneQuarterArc(point: lastPoint, radius: radius, direction: .topToLeft))
        lastPoint = CGPoint(x: lastPoint.x - radius, y: lastPoint.y + radius)
        path.append(drawLine(from: lastPoint, to: endPoint))
        return path
    }
    
    // L型Path
    func drawBigOneQuarterArcLeftToDown(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: endPoint.y - radius)))
        path.append(drawOneQuarterArc(point: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y), radius: radius, direction: .leftToDown))
        path.append(drawLine(from: CGPoint(x: path.currentPoint.x + radius, y: path.currentPoint.y + radius), to: endPoint))
        return path
    }
    
    // 水平翻轉L型Path
    func drawBigOneQuarterArcRightToDown(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: startPoint.x, y: endPoint.y - radius)))
        path.append(drawOneQuarterArc(point: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y), radius: radius, direction: .rightToDown))
        path.append(drawLine(from: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y), to: endPoint))
        return path
    }
    
    // 逆時針旋轉水平翻轉L型Path
    func drawBigOneQuarterArcTopToRight(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: endPoint.x - radius, y: startPoint.y)))
        path.append(drawOneQuarterArc(point: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y), radius: radius, direction: .topToRight))
        path.append(drawLine(from: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y), to: endPoint))
        return path
    }
    
    // 垂直翻轉L型Path
    func drawBigOneQuarterArcTopToLeft(from startPoint: CGPoint, to endPoint: CGPoint, radius: CGFloat, defaultSpace: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.append(drawLine(from: startPoint, to: CGPoint(x: endPoint.x + radius, y: startPoint.y)))
        path.append(drawOneQuarterArc(point: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y), radius: radius, direction: .topToLeft))
        path.append(drawLine(from: CGPoint(x: path.currentPoint.x - radius, y: path.currentPoint.y + radius), to: endPoint))
        return path
    }
}

extension PathDirection {
    var startAngle: Int {
        switch self {
        case .topToLeft:
            return 180
        case .topToRight:
            return 270
        case .rightToTop:
            return 270
        case .leftToTop:
            return 180
        case .rightToDown:
            return 0
        case .leftToDown:
            return 90
        case .downToLeft:
            return 90
        case .downToRight:
            return 0
        }
    }
    
    var endAngle: Int {
        switch self {
        case .topToLeft:
            return 270
        case .topToRight:
            return 360
        case .rightToTop:
            return 360
        case .leftToTop:
            return 270
        case .rightToDown:
            return 90
        case .leftToDown:
            return 180
        case .downToLeft:
            return 180
        case .downToRight:
            return 90
        }
    }
}

