//
//  SpotConfig.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2022/1/4.
//

import UIKit

public struct SpotConfig {
    
    static let `default` = SpotConfig()
    
    // 高度
    public var height: CGFloat = 7
    
    // 長度
    public var length: CGFloat = 7
    
    public var color: UIColor = .white
    
    public var lineColor: UIColor = .clear
    
    public var lineWidth: CGFloat = 0
    
    public init() {}
}
