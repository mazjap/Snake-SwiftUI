//
//  Position.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/8/21.
//

import Foundation

struct Position: Equatable {
    let x: Int
    let y: Int
    
    func next(in direction: Direction) -> Position {
        switch direction {
        case .up:
            return offset(x: 0, y: 1)
        case .down:
            return offset(x: 0, y: -1)
        case .left:
            return offset(x: 1, y: 0)
        case .right:
            return offset(x: -1, y: 0)
        }
    }
    
    func offset(x dx: Int = 0, y dy: Int = 0) -> Position {
        Position(x: x + dx, y: y + dy)
    }
    
    func isWithinBounds(for difficulty: Difficulty) -> Bool {
        return x < difficulty.rawValue &&
            y < difficulty.rawValue &&
            x >= 0 &&
            y >= 0
    }
    
    static let zero = Position(x: 0, y: 0)
    static let invalid = Position(x: -1, y: -1)
    
    static func mid(for difficulty: Difficulty) -> Position {
        let mid = Int(difficulty.rawValue / 2)
        
        return Position(x: mid, y: mid)
    }
    
    static func randomPosition(for difficulty: Difficulty) -> Position {
        let x = Int.random(in: 0..<Int(difficulty.rawValue))
        let y = Int.random(in: 0..<Int(difficulty.rawValue))
        
        return Position(x: x, y: y)
    }
}
