//
//  Direction.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/8/21.
//

import Foundation

enum Direction {
    case up, down, left, right
    
    func move(from position: Position) -> Position {
        switch self {
        case    .up: return Position(x: position.x, y: position.y++)
        case  .down: return Position(x: position.x, y: position.y--)
        case .right: return Position(x: position.x++, y: position.y)
        case  .left: return Position(x: position.x--, y: position.y)
        }
    }
    
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
