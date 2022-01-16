//
//  CircleShape.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

class CircleShape: RectShape {
    override func configure() {
        super.configure()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
    override func setupContentView() {
        contentView?.removeFromSuperview()
        guard let contentView = contentView else { return }
        addSubview(contentView)
        let constant = frame.width / 4
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant).isActive = true
    }
}
