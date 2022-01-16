//
//  ContentConfig.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

/// 文字內容Config
public struct ContentConfig {
    
    static let `default` = ContentConfig()
    
    /// 內容顏色
    public var contentColor: UIColor = .white
    
    /// 內容文字大小
    public var contentSize: CGFloat = 14
    
    // init
    public init(color: UIColor = .white, size: CGFloat = 14) {
        contentColor = color
        contentSize = size
    }
}
