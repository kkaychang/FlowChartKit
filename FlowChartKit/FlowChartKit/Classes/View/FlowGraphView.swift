//
//  FlowGraphView.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/28.
//

import UIKit

public class FlowGraphView: UIView {
    
    private var flowGraph: FlowGraph?
    
    private var isLayoutSubViews: Bool = false
    
    private var allLayers: [CAShapeLayer] = []
    
    lazy var pathUtil: DrawPathUtil = {
        return DrawPathUtil()
    }()
    
    public init(flowGraph: FlowGraph? = nil) {
        self.flowGraph = flowGraph
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    public override func layoutSubviews() {
        isLayoutSubViews = true
        if let flowGraph = flowGraph {
            draw(flowGraph)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func draw(_ flowGraph: FlowGraph) {
        guard isLayoutSubViews else {
            if !isLayoutSubViews {
                self.flowGraph = flowGraph
                layoutIfNeeded()
            }
            return
        }
        setupGraphViews(flowGraphGroup: flowGraph.groups)
        setupDrawLinePlan(linePlans: flowGraph.drawingPlans)
    }
    
    /// 設定圖框位置
    private func setupGraphViews(flowGraphGroup: [FlowGraphGroup]) {
        
        var leftPreGraph: UIView?
        
        flowGraphGroup.enumerated().forEach { group in
            var preGraph: UIView?
            
            switch group.element.groupAxis {
            case .horizontal(let offset):
                let groupHorizontalOffset = offset.left + offset.right
                let fiexdList = group.element.views.filter { $0.isFixedWidth }
                let fixedOffset = fiexdList.reduce(0) { sum, view in
                    return sum + view.size.width
                }
                let horizontalOffset = group.element.views.reduce(0) { sum, view in
                    return sum + view.offSet.left + view.offSet.right
                }
                let eachWidth = (frame.width - groupHorizontalOffset - horizontalOffset - fixedOffset) / CGFloat(group.element.views.count - fiexdList.count)
                
                group.element.views.forEach {
                    $0.display()
                    $0.widthAnchor.constraint(equalToConstant: $0.size.width).isActive = $0.isFixedWidth
                    $0.widthAnchor.constraint(equalToConstant: eachWidth).isActive = !$0.isFixedWidth
                    
                    if let preView = preGraph {
                        NSLayoutConstraint.activate([
                            $0.topAnchor.constraint(equalTo: preView.topAnchor),
                            $0.leadingAnchor.constraint(equalTo: preView.trailingAnchor, constant: $0.offSet.left),
                            $0.heightAnchor.constraint(equalToConstant: $0.size.height)
                        ])
                        preGraph = $0
                    } else {
                        NSLayoutConstraint.activate([
                            $0.topAnchor.constraint(equalTo: topAnchor, constant: offset.top),
                            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset.left),
                            $0.heightAnchor.constraint(equalToConstant: $0.size.height)
                        ])
                        preGraph = $0
                    }
                }
            case .vertical(let topOffset, let align):
                let eachWidth = group.element.views.map { $0.size.width }.max() ?? 150
                group.element.views.forEach {
                    $0.display()
                    
                    switch align {
                    case .left(let leftOffset):
                        var leftAnchor = leadingAnchor
                        if let leftPreGraph = leftPreGraph {
                            leftAnchor = leftPreGraph.trailingAnchor
                        }
                        NSLayoutConstraint.activate([
                            $0.leadingAnchor.constraint(equalTo: leftAnchor, constant: leftOffset),
                        ])
                    case .right(let rightOffset):
                        NSLayoutConstraint.activate([
                            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -rightOffset),
                        ])
                    }
                    
                    NSLayoutConstraint.activate([
                        $0.widthAnchor.constraint(equalToConstant: eachWidth),
                        $0.heightAnchor.constraint(equalToConstant: $0.size.height)
                    ])
                    
                    if let preView = preGraph {
                        NSLayoutConstraint.activate([
                            $0.topAnchor.constraint(equalTo: preView.bottomAnchor, constant: $0.offSet.top)
                        ])
                    } else {
                        NSLayoutConstraint.activate([
                            $0.topAnchor.constraint(equalTo: topAnchor, constant: topOffset)
                        ])
                        
                    }
                    preGraph = $0
                }
                leftPreGraph = preGraph
            }
        }
        layoutIfNeeded()
    }
    
    private func setupDrawLinePlan(linePlans: [DrawingLinkPlan]) {
        allLayers.forEach { layer in
            self.layer.sublayers?.first(where: { sublayer in
                sublayer.name == layer.name
            })?.removeFromSuperlayer()
        }
        
        allLayers = []
        
        linePlans.enumerated().forEach {
            drawPathWithNodes(plan: $0.element, id: $0.offset)
        }
    }
    
    private func drawPathWithNodes(plan: DrawingLinkPlan, id: Int) {
        let startNode = plan.startNode
        let endNode = plan.endNode
        
        let position = startNode.view.getOtherViewPosition(with: endNode.view)
        
        var subLayer: CAShapeLayer = CAShapeLayer()
        
        // 開始畫圖
        switch (startNode.direction, endNode.direction) {
        case (.top, .top):
            subLayer = drawNodeTopToNodeTop(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.top, .left):
            subLayer = drawNodeTopToNodeLeft(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.top, .right):
            subLayer = drawNodeTopToNodeRight(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
        
        case (.top, .down):
            subLayer = drawNodeTopToNodeBottom(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.right, .left):
            subLayer = drawNodeRightToNodeLeft(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.right, .right):
            subLayer = drawNodeRightToNodeRight(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.down, .right):
            subLayer = drawNodeBottomToNodeRight(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.down, .left):
            subLayer = drawNodeBottomToNodeLeft(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.down, .down):
            subLayer = drawNodeBottomToNodeBottom(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
        
        // 反轉
        case (.right, .top):
            subLayer = drawNodeRightToNodeTop(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.left, .top):
            subLayer = drawNodeLeftToNodeTop(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.down, .top):
            subLayer = drawNodeBottomToNodeTop(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.right, .down):
            subLayer = drawNodeRightToNodeDown(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
        
        case (.left, .right):
            subLayer = drawNodeLeftToNodeRight(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
        
        case (.left, .down):
            subLayer = drawNodeLeftToNodeDown(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        case (.left, .left):
            subLayer = drawNodeLeftToNodeLeft(startNode: startNode, endNode: endNode, preferDirection: plan.preferDirection, otherViewPosition: position)
            
        default:
            break
        }
        
        // add layer
        let layer = CAShapeLayer()
        layer.name = "shapeLayer_\(id)"
        layer.addSublayer(subLayer)
        allLayers.append(layer)
        self.layer.addSublayer(layer)
    }
}

extension DrawDirection {
    func getCenterPoint(view: UIView) -> CGPoint {
        switch self {
        case .up:
            return view.topCenter
        case .left:
            return view.leftCenter
        case .right:
            return view.rightCenter
        case .down:
            return view.bottomCenter
        }
    }
}

extension UIView {
    func getOtherViewPosition(with view: UIView) -> ViewPosition {
        
        if center.x == view.center.x {
            return getDistanceWithBaseView(with: view, select: .minY) < 0 ? .bottom : .top
        }
        
        if center.y == view.center.y {
            return getDistanceWithBaseView(with: view, select: .minX) < 0 ? .right : .left
        }
        
        if center.y > view.center.y && center.x > view.center.x {
            return .topLeft
        }
        
        if center.y > view.center.y && center.x < view.center.x {
            return .topRight
        }
        
        if center.y < view.center.y && center.x > view.center.x {
            return .downLeft
        }
        
        if center.y < view.center.y && center.x < view.center.x {
            return .downRight
        }
        
        return .topLeft
    }
}
