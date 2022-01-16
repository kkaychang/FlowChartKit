//
//  EdgeOffsets.swift
//  CMFlowChartKit
//
//  Created by Kay Chang on 2022/1/5.
//

import UIKit

public struct EdgeOffsets {
    public let top: CGFloat
    public let left: CGFloat
    public let bottom: CGFloat
    public let right: CGFloat

    public init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
      self.top = top
      self.left = left
      self.bottom = bottom
      self.right = right
    }
}
