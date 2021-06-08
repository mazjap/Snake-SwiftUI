//
//  Position.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/8/21.
//

import Foundation

struct Position: Equatable {
    let x: UInt
    let y: UInt
    
    func offset(x dx: UInt = 0, y dy: UInt = 0) -> Position {
        Position(x: x + dx, y: y + dy)
    }
    
    func isWithinBounds(for difficulty: Difficulty) -> Bool {
        return x < difficulty.rawValue && y < difficulty.rawValue
    }
    
    static let zero = Position(x: 0, y: 0)
    
    static func mid(for difficulty: Difficulty) -> Position {
        let mid = difficulty.rawValue / 2
        
        return Position(x: mid, y: mid)
    }
}
