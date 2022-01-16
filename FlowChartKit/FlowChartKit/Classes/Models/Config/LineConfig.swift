//
//  LineConfig.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/28.
//

import UIKit

public struct LineConfig {
    /// 線條顏色
    public var lineColor: UIColor = .white
    
    /// 線條寬度
    public var lineWidth: CGFloat = 1
    
    /// 轉彎弧度
    public var radius: CGFloat = 4
    
    /// 線與圖預設間距
    public var drawSpace: CGFloat = 9
    
    // TODO: 虛線
    
    public init() {}
}
