//
//  ShapeFactory.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

class ShapeFactory {
    
    private let parentView: UIView
    
    init(parentView: UIView) {
        self.parentView = parentView
    }
    
    func createShapeView(shape: Shapes, contentView: UIView?, nodeConfig: NodeConfig, offSet: EdgeOffsets, isFixedWidth: Bool = false) -> ShapeViewProtocol {
        switch shape {
        case .circle:
            return CircleShape(size: shape.size, parentView: parentView, contentView: contentView, nodeConfig: nodeConfig, offSet: offSet, isFixedWidth: true)
        case .rect:
            return RectShape(size: shape.size, parentView: parentView, contentView: contentView, nodeConfig: nodeConfig, offSet: offSet, isFixedWidth: isFixedWidth)
        case .diamond:
            return DiamondShape(size: shape.size, parentView: parentView, contentView: contentView, nodeConfig: nodeConfig, offSet: offSet, isFixedWidth: true)
        }
    }
}
