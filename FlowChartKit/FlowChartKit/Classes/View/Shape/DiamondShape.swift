//
//  DiamondShape.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

class DiamondShape: RectShape {
    
    private let degree = CGFloat.pi / 180
    
    override func configure() {
        super.configure()
        transform = CGAffineTransform(rotationAngle: degree * 45)
    }
    
    override func setupContentView() {
        super.setupContentView()
        contentView?.transform = CGAffineTransform(rotationAngle: degree * -45)
    }
}
