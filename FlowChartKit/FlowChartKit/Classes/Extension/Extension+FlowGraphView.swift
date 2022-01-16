//
//  Extension+FlowGraphView.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/30.
//

import UIKit

extension FlowGraphView {
    
    // MARK: - Top to Top
    func drawNodeTopToNodeTop(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = startNode.view.getOtherViewPosition(with: endNode.view)
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius

        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        var startNodeView = startNode.view
        var endNodeView = endNode.view
        var startCenter = startNode.getCenterPoint()
        var endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        var realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y - startSpotWidth)
        var realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y - endSpotWidth)
        
        switch position {
        case .top:
            space = CGFloat(startNodeView.leftTop.y - endNodeView.leftDown.y) / 2
            path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realEndCenter, to: CGPoint(x: endNodeView.leftTop.x - drawSpace, y: endNodeView.leftTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y: endNodeView.leftDown.y)))
            path.append(pathUtil.drawLineTopTurnLeftAndTurnRight(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: space > 0 ? space : 0))
        case .left:
            path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realEndCenter, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .right:
            path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realStartCenter, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        case .bottom:
            space = CGFloat(endNodeView.leftTop.y - startNodeView.leftDown.y) / 2
            path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realStartCenter, to: CGPoint(x: startNodeView.leftTop.x - drawSpace, y: startNodeView.leftTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y: startNodeView.leftDown.y)))
            path.append(pathUtil.drawLineTopTurnLeftAndTurnRight(from: path.currentPoint, to: endCenter, radius: radius, defaultSpace: space > 0 ? space : 0))
        case .topLeft, .downRight:
            if position == .downRight {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y - startSpotWidth)
                realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y - endSpotWidth)
            }
            if startCenter.x > endNodeView.rightTop.x {
                path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realEndCenter, to: CGPoint(x: startCenter.x , y: endNodeView.rightTop.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawLine(from: path.currentPoint, to: realStartCenter))
            } else if startNodeView.leftTop.x < endNodeView.rightTop.x && startCenter.x > endCenter.x {
                path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realEndCenter, to: CGPoint(x: endNodeView.rightTop.x + drawSpace, y: endNodeView.rightTop.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y: endNodeView.leftDown.y)))
                space = CGFloat(startNodeView.leftTop.y - endNodeView.rightDown.y) / 2
                path.append(pathUtil.drawLineTopTurnRightAndTurnLeft(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: space > 0 ? space : 0))
            }
        case .topRight, .downLeft:
            if position == .downLeft {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y - startSpotWidth)
                realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y - endSpotWidth)
            }
            if startCenter.x < endNodeView.leftTop.x {
                path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realEndCenter, to: CGPoint(x: startCenter.x, y: endNodeView.leftTop.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawLine(from: path.currentPoint, to: realStartCenter))
            } else if startNodeView.rightTop.x > endNodeView.leftTop.x && startCenter.x < endCenter.x {
                path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realEndCenter, to: CGPoint(x: endNodeView.leftTop.x - drawSpace, y: endNodeView.leftTop.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y: endNodeView.leftDown.y)))
                space = CGFloat(startNodeView.rightTop.y - endNodeView.leftDown.y) / 2
                path.append(pathUtil.drawLineTopTurnLeftAndTurnRight(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: space > 0 ? space : 0))
            }
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        
        return layer
    }
    
    // MARK: - Top to Left
    func drawNodeTopToNodeLeft(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {

        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        let startNodeView = startNode.view
        let endNodeView = endNode.view
        let startCenter = startNode.getCenterPoint()
        let endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        let realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y - startSpotWidth)
        let realEndCenter = CGPoint(x: endCenter.x - endSpotWidth, y: endCenter.y)
        
        switch position {
        case .left, .downLeft:
            path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realStartCenter, to: CGPoint(x: endNodeView.leftTop.x - drawSpace - endSpotWidth, y: endNodeView.leftTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: path.currentPoint, to: endCenter, radius: radius, defaultSpace: drawSpace))
        case .right, .downRight:
            space = (endNodeView.leftTop.x - startNodeView.rightTop.x) / 2
            path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realStartCenter, to: CGPoint(x: endNodeView.leftTop.x - drawSpace - endSpotWidth, y: startNodeView.rightTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: path.currentPoint, to: endNodeView.leftCenter, radius: radius, defaultSpace: drawSpace))
        case .bottom:
            path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realStartCenter, to: CGPoint(x: endNodeView.leftTop.x - drawSpace - endSpotWidth, y: endNodeView.leftTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: path.currentPoint, to: endNodeView.leftCenter, radius: radius, defaultSpace: drawSpace))
        case .topLeft, .top:
            space = (startNodeView.leftTop.y - endNodeView.rightDown.y) / 2
            path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: realEndCenter, to: CGPoint(x: endCenter.x, y: endNodeView.leftDown.y + space), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: CGPoint(x: path.currentPoint.x, y: endNodeView.leftDown.y + space), to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            
        case .topRight:
            if startCenter.x < endNodeView.leftTop.x {
                path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: realEndCenter, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            } else {
                space = (startNodeView.leftTop.y - endNodeView.rightDown.y) / 2
                path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: realEndCenter, to: CGPoint(x: endCenter.x, y: endNodeView.leftDown.y + space), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: CGPoint(x: endCenter.x, y: endNodeView.leftDown.y + space), to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            }
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        
        return layer
    }
    
    // MARK: - Top to Right
    func drawNodeTopToNodeRight(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        let startNodeView = startNode.view
        let endNodeView = endNode.view
        let startCenter = startNode.getCenterPoint()
        let endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        let realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y - startSpotWidth)
        let realEndCenter = CGPoint(x: endCenter.x + endSpotWidth, y: endCenter.y)
        
        switch position {
        case .left, .downLeft:
            space = (startNodeView.leftTop.x - endNodeView.rightTop.x) / 2
            path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realStartCenter, to: CGPoint(x: startNodeView.leftTop.x - space + endSpotWidth, y: startNodeView.leftTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: path.currentPoint, to: endNodeView.rightCenter, radius: radius, defaultSpace: drawSpace))
        case .right, .downRight:
            path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realStartCenter, to: CGPoint(x: endNodeView.rightTop.x + drawSpace + endSpotWidth, y: endNodeView.rightTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: path.currentPoint, to: endNodeView.rightCenter, radius: radius, defaultSpace: drawSpace))
        case .bottom:
            path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realStartCenter, to: CGPoint(x: startNodeView.rightTop.x + drawSpace + startSpotWidth, y: startNodeView.rightTop.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: path.currentPoint, to: endNodeView.rightCenter, radius: radius, defaultSpace: drawSpace))
        case .topLeft:
            if startCenter.x > endNodeView.rightTop.x {
                path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: endNodeView.rightCenter, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            } else {
                space = (startNodeView.leftTop.y - endNodeView.rightDown.y) / 2
                path.append(pathUtil.drawRightLineWithTwoArcFrom(from: endCenter, to: CGPoint(x: endCenter.x, y: endNodeView.rightDown.y + space), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: CGPoint(x: endCenter.x, y: endNodeView.leftDown.y + space), to: startCenter, radius: radius, defaultSpace: drawSpace))
            }
        case .topRight, .top:
            space = (startNodeView.rightTop.y - endNodeView.rightDown.y) / 2
            path.append(pathUtil.drawRightLineWithTwoArcFrom(from: realEndCenter, to: CGPoint(x: endCenter.x + drawSpace, y: endNodeView.rightDown.y + space), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        
        return layer
    }
    
    // MARK: - Top to Bottom
    func drawNodeTopToNodeBottom(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        let startNodeView = startNode.view
        let endNodeView = endNode.view
        let startCenter = startNode.getCenterPoint()
        let endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        let realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y - startSpotWidth)
        let realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y + endSpotWidth)
        
        switch position {
        case .top:
            path.append(pathUtil.drawLine(from: realStartCenter, to: endNodeView.bottomCenter))
        case .topLeft, .topRight:
            space = (startNodeView.topCenter.y - endNodeView.bottomCenter.y) / 2
            if startCenter.x < endCenter.x {
                path.append(pathUtil.drawLineTopTurnRightAndTurnLeft(from: realEndCenter, to: realStartCenter, radius: radius, defaultSpace: space > 0 ? space : drawSpace))
            }
            if startCenter.x > endCenter.x {
                path.append(pathUtil.drawLineTopTurnLeftAndTurnRight(from: realEndCenter, to: realStartCenter, radius: radius, defaultSpace: space > 0 ? space : drawSpace))
            }
        case .left, .downLeft:
            space = (startNodeView.leftCenter.x - endNodeView.rightCenter.x) / 2
            path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realStartCenter, to: CGPoint(x: startNodeView.leftCenter.x - space, y: startNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y: endNodeView.bottomCenter.y + endSpotWidth)))
            path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        case .right, .downRight:
            space = (endNodeView.leftCenter.x - startNodeView.rightCenter.x) / 2
            path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realStartCenter, to: CGPoint(x: startNodeView.rightCenter.x + space, y: startNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y:endNodeView.bottomCenter.y + endSpotWidth)))
            path.append(pathUtil.drawBottomLineWithTwoArcFromLeftToRight(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        case .bottom:
            if preferDirection == .left {
                path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: realStartCenter, to: CGPoint(x: startNodeView.leftCenter.x - drawSpace, y: startNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y: endNodeView.bottomCenter.y + endSpotWidth)))
                path.append(pathUtil.drawBottomLineWithTwoArcFromLeftToRight(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
            }
            if preferDirection == .right {
                path.append(pathUtil.drawTopLineWithTwoArcFromLeftToRight(from: realStartCenter, to: CGPoint(x: startNodeView.rightCenter.x + drawSpace, y: startNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: path.currentPoint.x, y: endNodeView.bottomCenter.y + endSpotWidth)))
                path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
            }
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        return layer
    }
    
    // MARK: - Right to Right
    func drawNodeRightToNodeRight(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        var startNodeView = startNode.view
        var endNodeView = endNode.view
        var startCenter = startNode.getCenterPoint()
        var endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        var realStartCenter = CGPoint(x: startCenter.x + startSpotWidth, y: startCenter.y)
        var realEndCenter = CGPoint(x: endCenter.x + endSpotWidth, y: endCenter.y)
        
        switch position {
        case .top:
            path.append(pathUtil.drawRightLineWithTwoArcFrom(from: realEndCenter, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .topLeft, .downRight:
            if position == .downRight {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x + startSpotWidth, y: startCenter.y)
                realEndCenter = CGPoint(x: endCenter.x + endSpotWidth, y: endCenter.y)
            }
            path.append(pathUtil.drawLine(from: realEndCenter, to: CGPoint(x: startNodeView.rightCenter.x + startSpotWidth, y: endCenter.y)))
            path.append(pathUtil.drawRightLineWithTwoArcFrom(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .topRight, .downLeft:
            if position == .downLeft {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x + startSpotWidth, y: startCenter.y)
                realEndCenter = CGPoint(x: endCenter.x + endSpotWidth, y: endCenter.y)
            }
            path.append(pathUtil.drawRightLineWithTwoArcFrom(from: realEndCenter, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: startNodeView.rightCenter))
        case .left, .right:
            if position == .right {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x + startSpotWidth, y: startCenter.y)
                realEndCenter = CGPoint(x: endCenter.x + endSpotWidth, y: endCenter.y)
            }
            space = (startNodeView.leftCenter.x - endNodeView.rightCenter.x) / 2
            if preferDirection == .up {
                let startPoint = CGPoint(x: realStartCenter.x + drawSpace, y: startNodeView.topCenter.y)
                path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: startPoint, to: startCenter, radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: startPoint, to: CGPoint(x: startNodeView.leftCenter.x - space + endSpotWidth, y: startNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
            }
            if preferDirection == .down {
                path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: realStartCenter, to: CGPoint(x: startNodeView.rightCenter.x + drawSpace + startSpotWidth, y: startNodeView.bottomCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: CGPoint(x: startNodeView.leftCenter.x - space + endSpotWidth, y: startNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: realEndCenter, to: path.currentPoint, radius: radius, defaultSpace: drawSpace))
            }
        case .bottom:
            path.append(pathUtil.drawRightLineWithTwoArcFrom(from: realStartCenter, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        return layer
    }
    
    // MARK: - Right to Left
    func drawNodeRightToNodeLeft(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        let startNodeView = startNode.view
        let endNodeView = endNode.view
        let startCenter = startNode.getCenterPoint()
        let endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        let realStartCenter = CGPoint(x: startCenter.x + startSpotWidth, y: startCenter.y)
        let realEndCenter = CGPoint(x: endCenter.x - endSpotWidth, y: endCenter.y)
        
        switch position {
        case .topLeft, .top:
            // [ + - + ]
            space = (startNodeView.topCenter.y - endNodeView.bottomCenter.y) / 2
            path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: realEndCenter, to: CGPoint(x: endNodeView.leftCenter.x, y: endNodeView.bottomCenter.y + space), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: startNodeView.rightCenter.x + startSpotWidth, y: path.currentPoint.y)))
            path.append(pathUtil.drawRightLineWithTwoArcFrom(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .topRight:
            // 『 + 』
            space = (endNodeView.leftCenter.x - startNodeView.rightCenter.x) / 2
            let highSpace = (startNodeView.topCenter.y - endNodeView.bottomCenter.y) / 2
            path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: realEndCenter, to: CGPoint(x: endNodeView.leftCenter.x - space, y: endNodeView.bottomCenter.y + highSpace), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .left:
            if preferDirection == .up {
                // ⤶ + ⥐ + ⤷
                let startPoint = CGPoint(x: realStartCenter.x + drawSpace, y: startNodeView.topCenter.y)
                path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: startPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: startPoint, to: CGPoint(x: endNodeView.leftCenter.x - drawSpace - endSpotWidth, y: endNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
            }
            if preferDirection == .down {
                // ⤵ + ⥎ + ⤷
                path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: realStartCenter, to: CGPoint(x: startNodeView.rightCenter.x + drawSpace + startSpotWidth, y: startNodeView.bottomCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: CGPoint(x: endNodeView.leftCenter.x - drawSpace - endSpotWidth, y: endNodeView.bottomCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: realEndCenter, to: path.currentPoint, radius: radius, defaultSpace: drawSpace))
            }
        case .right:
            // -
            path.append(pathUtil.drawLine(from: realStartCenter, to: realEndCenter))
        case .downLeft, .bottom:
            space = (endNodeView.topCenter.y - startNodeView.bottomCenter.y) / 2
            space = space > 0 ? space : 0
            path.append(pathUtil.drawRightLineWithTwoArcFrom(from: realStartCenter, to: CGPoint(x: startNodeView.rightCenter.x, y: space > 0 ? startNodeView.bottomCenter.y + space : endNodeView.bottomCenter.y + drawSpace), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: CGPoint(x: endNodeView.leftCenter.x - endSpotWidth, y: path.currentPoint.y)))
            if space > 0 {
                path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
            } else {
                path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: realEndCenter, to: path.currentPoint, radius: radius, defaultSpace: drawSpace))
            }
        case .downRight:
            space = (endNodeView.leftCenter.x - startNodeView.rightCenter.x) / 2
            let highSpace = (endNodeView.topCenter.y - startNodeView.bottomCenter.y) / 2
            path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: realStartCenter, to: CGPoint(x: startNodeView.rightCenter.x + space, y: endNodeView.topCenter.y - highSpace), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        return layer
    }
    
    // MARK: - Right to Top
    func drawNodeRightToNodeTop(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        
        switch position {
        case .topLeft:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downRight, lineConfig: lineConfig)
        case .top:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .bottom, lineConfig: lineConfig)
        case .topRight:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downLeft, lineConfig: lineConfig)
        case .left:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .right, lineConfig: lineConfig)
        case .right:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .left, lineConfig: lineConfig)
        case .downLeft:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topRight, lineConfig: lineConfig)
        case .bottom:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .top, lineConfig: lineConfig)
        case .downRight:
            return drawNodeTopToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topLeft, lineConfig: lineConfig)
        }
    }
    
    // MARK: - Right to Bottom
    func drawNodeRightToNodeDown(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        let position = otherViewPosition
        
        switch position {
        case .topLeft:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downRight, lineConfig: lineConfig)
        case .top:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .bottom, lineConfig: lineConfig)
        case .topRight:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downLeft, lineConfig: lineConfig)
        case .left:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .right, lineConfig: lineConfig)
        case .right:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .left, lineConfig: lineConfig)
        case .downLeft:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topRight, lineConfig: lineConfig)
        case .bottom:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .top, lineConfig: lineConfig)
        case .downRight:
            return drawNodeBottomToNodeRight(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topLeft, lineConfig: lineConfig)
        }
    }
    
    // MARK: - Left to Top
    func drawNodeLeftToNodeTop(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        let position = otherViewPosition
        
        switch position {
        case .topLeft:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downRight, lineConfig: lineConfig)
        case .top:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .bottom, lineConfig: lineConfig)
        case .topRight:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downLeft, lineConfig: lineConfig)
        case .left:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .right, lineConfig: lineConfig)
        case .right:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .left, lineConfig: lineConfig)
        case .downLeft:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topRight, lineConfig: lineConfig)
        case .bottom:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .top, lineConfig: lineConfig)
        case .downRight:
            return drawNodeTopToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topLeft, lineConfig: lineConfig)
        }
    }
    
    // MARK: - Bottom to Top
    func drawNodeBottomToNodeTop(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        let position = otherViewPosition
        
        switch position {
        case .topLeft:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downRight, lineConfig: lineConfig)
        case .top:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .bottom, lineConfig: lineConfig)
        case .topRight:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downLeft, lineConfig: lineConfig)
        case .left:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .right, lineConfig: lineConfig)
        case .right:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .left, lineConfig: lineConfig)
        case .downLeft:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topRight, lineConfig: lineConfig)
        case .bottom:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .top, lineConfig: lineConfig)
        case .downRight:
            return drawNodeTopToNodeBottom(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topLeft, lineConfig: lineConfig)
        }
    }
    
    // MARK: - Bottom to Right
    func drawNodeBottomToNodeRight(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor

        // 初始路徑
        let path = UIBezierPath()
        
        let startNodeView = startNode.view
        let endNodeView = endNode.view
        let startCenter = startNode.getCenterPoint()
        let endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        let realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y + startSpotWidth)
        let realEndCenter = CGPoint(x: endCenter.x + endSpotWidth, y: endCenter.y)
        
        // ⤴ ⤵ ⤶ ⤷ ⥊ ⥋ ⥌ ⥍ ⥎ ⥐ ⥏ ⥑ ↰ ↱ ↲ ↳ ↴ ↵
        switch position {
        case .topLeft, .left:
            // end ↴ + ⥎ start
            space = (startNodeView.leftCenter.x - endCenter.x) / 2
            path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: realEndCenter, to: CGPoint(x: startNodeView.leftCenter.x - space + endSpotWidth, y: startNodeView.bottomCenter.y + startSpotWidth), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBottomLineWithTwoArcFromLeftToRight(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .top, .topRight, .right:
            // end ↴ + ⥎ start
            path.append(pathUtil.drawBigOneQuarterArcTopToRight(from: realEndCenter, to: CGPoint(x: endNodeView.rightCenter.x + drawSpace + endSpotWidth, y: startNodeView.bottomCenter.y + startSpotWidth), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .downLeft:
            // start ↲ end
            path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: realStartCenter, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        case .bottom, .downRight:
            // start ㄣ ＋ ↲ end
            space = (endNodeView.topCenter.y - startCenter.y) / 2
            path.append(pathUtil.drawLineTopTurnLeftAndTurnRight(from: realStartCenter, to: CGPoint(x: endNodeView.rightCenter.x + drawSpace + endSpotWidth, y: endNodeView.topCenter.y + endSpotWidth), radius: radius, defaultSpace: space))
            path.append(pathUtil.drawBigOneQuarterArcRightToDown(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        
        return layer
    }
    
    // MARK: - Bottom to Left
    func drawNodeBottomToNodeLeft(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        let startNodeView = startNode.view
        let endNodeView = endNode.view
        let startCenter = startNode.getCenterPoint()
        let endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        let realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y + startSpotWidth)
        let realEndCenter = CGPoint(x: endCenter.x - endSpotWidth, y: endCenter.y)
        
        switch position {
        case .topLeft, .left, .top:
            // end ⤷ + ⥎ start
            path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: realEndCenter, to: CGPoint(x: endNodeView.leftCenter.x - drawSpace - endSpotWidth, y: startNodeView.bottomCenter.y + startSpotWidth), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBottomLineWithTwoArcFromLeftToRight(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .topRight, .right:
            // end ⤷ + ⥎ start
            space = (endCenter.x - startNodeView.rightCenter.x) / 2
            path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: realEndCenter, to: CGPoint(x: endNodeView.leftCenter.x - space - endSpotWidth, y: startNodeView.bottomCenter.y + startSpotWidth), radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .downRight:
            // start ⤷ end
            path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: realStartCenter, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        case .bottom, .downLeft:
            // start 水平ㄣ ＋ ⤷ end
            space = (endNodeView.topCenter.y - startNodeView.bottomCenter.y) / 2
            path.append(pathUtil.drawLineTopTurnRightAndTurnLeft(from: realStartCenter, to: CGPoint(x: endNodeView.leftCenter.x - drawSpace - endSpotWidth, y: endNodeView.topCenter.y), radius: radius, defaultSpace: space))
            path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        
        return layer
    }
    
    // MARK: - Bottom to Bottom
    func drawNodeBottomToNodeBottom(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = otherViewPosition
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        var startNodeView = startNode.view
        var endNodeView = endNode.view
        var startCenter = startNode.getCenterPoint()
        var endCenter = endNode.getCenterPoint()
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        var realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y + startSpotWidth)
        var realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y + endSpotWidth)
        
        switch position {
        case .topLeft, .downRight, .left:
            if position == .downRight {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y + startSpotWidth)
                realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y + endSpotWidth)
            }
            path.append(pathUtil.drawLine(from: realEndCenter, to: CGPoint(x: endCenter.x, y: startNodeView.bottomCenter.y + endSpotWidth)))
            path.append(pathUtil.drawBottomLineWithTwoArcFromLeftToRight(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .topRight, .downLeft, .right:
            if position == .downLeft {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y + startSpotWidth)
                realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y + endSpotWidth)
            }
            path.append(pathUtil.drawLine(from: realEndCenter, to: CGPoint(x: endCenter.x, y: startNodeView.bottomCenter.y + startSpotWidth)))
            path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .top, .bottom:
            if position == .bottom {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x, y: startCenter.y + startSpotWidth)
                realEndCenter = CGPoint(x: endCenter.x, y: endCenter.y + endSpotWidth)
            }
            if preferDirection == .left {
                path.append(pathUtil.drawLineTopTurnRightAndTurnLeft(from: realEndCenter, to: CGPoint(x: startNodeView.leftCenter.x - drawSpace, y: startNodeView.bottomCenter.y + startSpotWidth), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBottomLineWithTwoArcFromLeftToRight(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            }
            if preferDirection == .right {
                path.append(pathUtil.drawLineTopTurnLeftAndTurnRight(from: realEndCenter, to: CGPoint(x: startNodeView.rightCenter.x + drawSpace, y: startNodeView.bottomCenter.y + startSpotWidth), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            }
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        return layer
    }
    
    // MARK: - Left to Bottom
    func drawNodeLeftToNodeDown(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        let position = otherViewPosition
        
        switch position {
        case .topLeft:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downRight, lineConfig: lineConfig)
        case .top:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .bottom, lineConfig: lineConfig)
        case .topRight:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downLeft, lineConfig: lineConfig)
        case .left:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .right, lineConfig: lineConfig)
        case .right:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .left, lineConfig: lineConfig)
        case .downLeft:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topRight, lineConfig: lineConfig)
        case .bottom:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .top, lineConfig: lineConfig)
        case .downRight:
            return drawNodeBottomToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topLeft, lineConfig: lineConfig)
        }
    }
    
    // MARK: - Left to Right
    func drawNodeLeftToNodeRight(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        let position = otherViewPosition
        
        switch position {
        case .topLeft:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downRight, lineConfig: lineConfig)
        case .top:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .bottom, lineConfig: lineConfig)
        case .topRight:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .downLeft, lineConfig: lineConfig)
        case .left:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .right, lineConfig: lineConfig)
        case .right:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .left, lineConfig: lineConfig)
        case .downLeft:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topRight, lineConfig: lineConfig)
        case .bottom:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .top, lineConfig: lineConfig)
        case .downRight:
            return drawNodeRightToNodeLeft(startNode: endNode, endNode: startNode, preferDirection: .left, otherViewPosition: .topLeft, lineConfig: lineConfig)
        }
    }
    
    // MARK: - Left to Left
    func drawNodeLeftToNodeLeft(startNode: DrawingNode, endNode: DrawingNode, preferDirection: DrawDirection, otherViewPosition: ViewPosition, lineConfig: LineConfig = LineConfig()) -> CAShapeLayer {
        
        let position = startNode.view.getOtherViewPosition(with: endNode.view)
        let drawSpace = lineConfig.drawSpace
        let radius = lineConfig.radius

        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineConfig.lineWidth
        layer.strokeColor = lineConfig.lineColor.cgColor
        
        // 初始路徑
        let path = UIBezierPath()
        
        var startNodeView = startNode.view
        var endNodeView = endNode.view
        var startCenter = startNode.getCenterPoint()
        var endCenter = endNode.getCenterPoint()
        var space: CGFloat
        
        let startSpotWidth: CGFloat = startNode.contackType.config?.length ?? 0
        let endSpotWidth: CGFloat = endNode.contackType.config?.length ?? 0
        var realStartCenter = CGPoint(x: startCenter.x - startSpotWidth, y: startCenter.y)
        var realEndCenter = CGPoint(x: endCenter.x - endSpotWidth, y: endCenter.y)
        
        switch position {
        case .top, .bottom:
            if position == .bottom {
                path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: realStartCenter, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
            } else {
                path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: realEndCenter, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
            }
        case .topLeft, .downRight:
            if position == .downRight {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x - startSpotWidth, y: startCenter.y)
                realEndCenter = CGPoint(x: endCenter.x - endSpotWidth, y: endCenter.y)
            }
            path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: realEndCenter, to: startCenter, radius: radius, defaultSpace: drawSpace))
            path.append(pathUtil.drawLine(from: path.currentPoint, to: realStartCenter))
        case .downLeft, .topRight:
            if position == .downLeft {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x - startSpotWidth, y: startCenter.y)
                realEndCenter = CGPoint(x: endCenter.x - endSpotWidth, y: endCenter.y)
            }
            path.append(pathUtil.drawLine(from: realEndCenter, to: CGPoint(x: startNodeView.leftCenter.x - endSpotWidth, y: endCenter.y)))
            path.append(pathUtil.drawLeftLineWithTwoArcFrom(from: CGPoint(x: startNodeView.leftCenter.x - startSpotWidth, y: endCenter.y), to: realStartCenter, radius: radius, defaultSpace: drawSpace))
        case .left, .right:
            if position == .right {
                startNodeView = endNode.view
                endNodeView = startNode.view
                startCenter = endNode.getCenterPoint()
                endCenter = startNode.getCenterPoint()
                realStartCenter = CGPoint(x: startCenter.x - startSpotWidth, y: startCenter.y)
                realEndCenter = CGPoint(x: endCenter.x - endSpotWidth, y: endCenter.y)
            }
            space = (startNodeView.leftCenter.x - endNodeView.rightCenter.x) / 2
            if preferDirection == .up {
                let startPoint = CGPoint(x: startNodeView.leftCenter.x - space - startSpotWidth, y: startNodeView.topCenter.y)
                path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: startPoint, to: realStartCenter, radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawTopLineWithTwoArcFromRightToLeft(from: startPoint, to: CGPoint(x: endNodeView.leftCenter.x - drawSpace - endSpotWidth, y: startNodeView.topCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcLeftToDown(from: path.currentPoint, to: realEndCenter, radius: radius, defaultSpace: drawSpace))
            }
            if preferDirection == .down {
                path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: realStartCenter, to: CGPoint(x: startNodeView.leftCenter.x - space - startSpotWidth, y: startNodeView.bottomCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBottomLineWithTwoArcFromRighToLeft(from: path.currentPoint, to: CGPoint(x: endNodeView.leftCenter.x - drawSpace - endSpotWidth, y: startNodeView.bottomCenter.y), radius: radius, defaultSpace: drawSpace))
                path.append(pathUtil.drawBigOneQuarterArcTopToLeft(from: realEndCenter, to: path.currentPoint, radius: radius, defaultSpace: drawSpace))
            }
        }
        layer.path = path.cgPath
        
        if let startSpot = startNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realStartCenter, startCenter), config: startSpot)
            layer.addSublayer(spotLayer)
        }
        
        if let endSpot = endNode.contackType.config {
            let spotLayer = CAShapeLayer.arrow(line: Line(realEndCenter, endCenter), config: endSpot)
            layer.addSublayer(spotLayer)
        }
        
        return layer
    }
}
