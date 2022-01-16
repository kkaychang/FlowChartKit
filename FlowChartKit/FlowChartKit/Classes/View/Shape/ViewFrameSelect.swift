//
//  ViewFrameSelect.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2022/1/5.
//

import UIKit

enum ViewFrameSelect {
    case minX
    case maxX
    case minY
    case maxY
}

extension UIView {
    func getDistanceWithBaseView(with view: UIView, select: ViewFrameSelect) -> CGFloat {
        switch select {
        case .minX:
            return frame.minX - view.frame.minX
        case .maxX:
            return frame.maxX - view.frame.maxX
        case .minY:
            return frame.minY - view.frame.minY
        case .maxY:
            return frame.maxY - view.frame.maxY
        }
    }
}
