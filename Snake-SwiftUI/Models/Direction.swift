//
//  Direction.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/8/21.
//

import Foundation

enum Direction {
    case up, down, left, right
    
    func isOpposite(of direction: Direction) -> Bool {
        switch self {
        case .up:
            return direction == .down
        case .down:
            return direction == .up
        case .left:
            return direction == .right
        case .right:
            return direction == .left
        }
    }
}
