//
//  DrawingLinkPlan.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

/// 連結圖計畫
public class DrawingLinkPlan {
    /// 起始點
    public let startNode: DrawingNode
    
    /// 結束點
    public let endNode: DrawingNode
    
    /// 線樣式
    public let lineConfig: LineConfig
    
    /// 偏好方向(當x或y軸一樣時，選擇偏好方向)
    public let preferDirection: DrawDirection
    
    // init
    public init(from startNode: DrawingNode, to endNode: DrawingNode, with lineConfig: LineConfig, preferDirection: DrawDirection = .left) {
        self.startNode = startNode
        self.endNode = endNode
        self.lineConfig = lineConfig
        self.preferDirection = preferDirection
    }
}

public class DrawingNode {
    /// 畫面
    public let view: UIView
    
    /// 方向
    public let direction: DrawDirection
    
    /// 連結樣式
    public let contackType: ContackType
    
    // init
    public init(_ view: UIView, from direction: DrawDirection, with type: ContackType) {
        self.view = view
        self.direction = direction
        self.contackType = type
    }
    
    public func getCenterPoint() -> CGPoint {
        return direction.getCenterPoint(view: view)
    }
}
