//
//  ShapeViewProtocol.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

public protocol ShapeViewProtocol: UIView {
    var size: CGSize { get }
    var parentView: UIView { get }
    var contentView: UIView? { get }
    var nodeConfig: NodeConfig { get }
    var offSet: EdgeOffsets { get }
    var isFixedWidth: Bool { get }
    func configure()
    func display()
    init(size: CGSize, parentView: UIView, contentView: UIView?, nodeConfig: NodeConfig, offSet: EdgeOffsets, isFixedWidth: Bool)
}

protocol NodeConfigProtocol {
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
}
