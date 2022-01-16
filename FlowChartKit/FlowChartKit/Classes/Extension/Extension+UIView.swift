//
//  Extension+UIView.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2022/1/5.
//

import UIKit

extension UIView {
    // 上中
    public var topCenter: CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.minY)
    }
    
    // 左中
    public var leftCenter: CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.midY)
    }
    
    // 右中
    public var rightCenter: CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.midY)
    }
    
    // 底中
    public var bottomCenter: CGPoint {
        return CGPoint(x: self.frame.midX, y: self.frame.maxY)
    }
    
    // 左上角
    public var leftTop: CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    // 右上角
    public var rightTop: CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.minY)
    }
    
    // 左下角
    public var leftDown: CGPoint {
        return CGPoint(x: self.frame.minX, y: self.frame.maxY)
    }
    
    // 右下角
    public var rightDown: CGPoint {
        return CGPoint(x: self.frame.maxX, y: self.frame.maxY)
    }
}
