//
//  Snake.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/6/20.
//

import Foundation



struct Snake {
    let head: Position
    let body: [Position]
    let direction: Direction
    
    init(head: Position, body: [Position], direction: Direction) {
        self.head = head
        self.body = body
        self.direction = direction
    }
}

struct Position {
    let x: Int
    let y: Int
    
    static let zero = Position(x: 0, y: 0)
    
    func offsetX(by amount: Int) {
        Position(x: x + amount, y: y)
    }
    
    func offsetY(by amount: Int) {
        Position(x: x, y: y + amount)
    }
    
    func offset(x dx: Int, y dy: Int) {
        Position(x: x + dx, y: y + dy)
    }
}

enum Difficulty: Int {
    case easy = 10
    case normal = 20
    case hard = 30
}

enum Direction {
    case up, down, left, right
}

