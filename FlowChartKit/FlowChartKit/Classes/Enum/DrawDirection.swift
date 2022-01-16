//
//  DrawDirection.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/27.
//

import Foundation

public enum DrawDirection {
    static let `top`: DrawDirection = .up
    static let `bottom`: DrawDirection = .down
    
    case up
    case left
    case down
    case right
    
    var opposite: DrawDirection {
        switch self {
        case .up: return .down
        case .left: return .right
        case .down: return .up
        case .right: return .left
        }
    }
}
