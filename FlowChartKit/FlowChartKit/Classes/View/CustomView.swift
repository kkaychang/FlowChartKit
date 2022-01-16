//
//  CustomView.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

class CustomView: UIView, ShapeViewProtocol {
    
    var size: CGSize
    
    var parentView: UIView
    
    var contentView: UIView?
    
    var nodeConfig: NodeConfig
    
    var offSet: EdgeOffsets
    
    var isFixedWidth: Bool
    
    required init(size: CGSize, parentView: UIView, contentView: UIView?, nodeConfig: NodeConfig, offSet: EdgeOffsets, isFixedWidth: Bool = false) {
        self.size = size
        self.parentView = parentView
        self.contentView = contentView
        self.nodeConfig = nodeConfig
        self.offSet = offSet
        self.isFixedWidth = isFixedWidth
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.frame = frame
        self.backgroundColor = nodeConfig.backgroundColor
    }
    
    func display() {
        configure()
        parentView.addSubview(self)
    }
}
