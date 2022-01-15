//
//  Direction.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/8/21.
//

import Foundation

enum Direction: Equatable {
    case up, down, left, right
    
    var opposite: Self {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
    static var defaultStartDirection: Self = .up
}
