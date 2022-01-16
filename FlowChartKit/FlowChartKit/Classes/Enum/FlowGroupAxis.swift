//
//  FlowGroupAxis.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/28.
//

import UIKit

public enum FlowGroupAxis {
    case vertical(topOffset: CGFloat, align: VerticalAlign)
    case horizontal(groupOffSet: EdgeOffsets)
}

public enum VerticalAlign {
    case left(leftOffset: CGFloat)
    case right(rightOffset: CGFloat)
}
