//
//  DrawingLine.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

public struct Line {
    public let from: CGPoint
    public let to: CGPoint
    
    public init(_ from: CGPoint, _ to: CGPoint) {
        self.from = from
        self.to = to
    }
}
