//
//  ContackType.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2021/12/28.
//

import Foundation

public enum ContackType {
    case none
    case arrow(config: SpotConfig)
    case circle(config: SpotConfig)
    
    var config: SpotConfig? {
        switch self {
        case .none:
            return nil
        case .arrow(let config):
            return config
        case .circle(let config):
            return config
        }
    }
}
