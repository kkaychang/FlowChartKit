//
//  NodeConfig.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

/// 節點樣式Config
public struct NodeConfig: NodeConfigProtocol {
    /// 背景顏色
    public var backgroundColor: UIColor = .darkGray
    
    /// 邊線顏色
    public var borderColor: UIColor
    
    /// 邊線寬度
    public var borderWidth: CGFloat
    
    /// 節點圓角
    public var cornerRadius: CGFloat
    
    // init
    public init(backgroundColor: UIColor = .darkGray,
                borderColor: UIColor = .clear,
                borderWidth: CGFloat = 0,
                cornerRadius: CGFloat = 0) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}
