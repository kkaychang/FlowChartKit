//
//  RectShape.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

class RectShape: UIView, ShapeViewProtocol {
    
    let size: CGSize
    
    let parentView: UIView
    
    var contentView: UIView?
    
    let offSet: EdgeOffsets
    
    let nodeConfig: NodeConfig
    
    let isFixedWidth: Bool
    
    required init(size: CGSize, parentView: UIView, contentView: UIView?, nodeConfig: NodeConfig, offSet: EdgeOffsets, isFixedWidth: Bool) {
        self.size = size
        self.parentView = parentView
        self.contentView = contentView
        self.nodeConfig = nodeConfig
        self.offSet = offSet
        self.isFixedWidth = isFixedWidth
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let frame = CGRect(x: 0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height))
        self.frame = frame
    }
    
    func display() {
        backgroundColor = nodeConfig.backgroundColor
        layer.borderColor = nodeConfig.borderColor.cgColor
        layer.borderWidth = nodeConfig.borderWidth
        layer.cornerRadius = nodeConfig.cornerRadius
        setupContentView()
        parentView.addSubview(self)
    }
    
    func setupContentView() {
        guard let contentView = contentView else { return }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
}
