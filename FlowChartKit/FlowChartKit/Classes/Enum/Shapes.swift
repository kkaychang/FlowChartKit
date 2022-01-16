//
//  Shapes.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import UIKit

public enum Shapes {
    case rect(_ width: CGFloat, _ height: CGFloat)
    case circle(_ width: CGFloat, _ height: CGFloat)
    case diamond(_ width: CGFloat, _ height: CGFloat)
    
    public var size: CGSize {
        switch self {
        case .rect(let width, let height):
            return CGSize(width: width, height: height)
        case .circle(let width, let height):
            return CGSize(width: width, height: height)
        case .diamond(let width, let height):
            return CGSize(width: width, height: height)
        }
    }
}
