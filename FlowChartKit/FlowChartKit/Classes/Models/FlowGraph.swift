//
//  FlowGraph.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/28.
//

import UIKit

public class FlowGraph {
    public let groups: [FlowGraphGroup]
    public let drawingPlans: [DrawingLinkPlan]
    
    public init(groups: [FlowGraphGroup], drawingPlans: [DrawingLinkPlan]) {
        self.groups = groups
        self.drawingPlans = drawingPlans
    }
}

public struct FlowGraphGroup {
    public let groupAxis: FlowGroupAxis
    public let views: [ShapeViewProtocol]
    
    public init(groupAxis: FlowGroupAxis, views: [ShapeViewProtocol]) {
        self.groupAxis = groupAxis
        self.views = views
    }
}
