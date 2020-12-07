//
//  SnakeController.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/7/20.
//

import Foundation

class SnakeController: ObservableObject {
    @Published var snake: Snake
    @Published var difficulty: Difficulty
    
    init(vCount: Int, difficulty: Difficulty) {
        self.difficulty = difficulty
        
        let head = Position(x: difficulty.rawValue, y: vCount / 2)
        let body = 
        self.snake = Snake(head: Position(x: difficulty.rawValue, y: vCount / 2), body: <#T##[Position]#>, direction: <#T##Direction#>)
    }
    
    func move() -> Snake {
        let head = snake.head
        let pos: Position
        
        switch snake.direction {
        case .up:
            pos = Position(x: head.x, y: head.y++)
        case .down:
            pos = Position(x: head.x, y: head.y--)
        case .right:
            pos = Position(x: head.x++, y: head.y)
        case .left:
            pos = Position(x: head.x--, y: head.y)
        }
        
        return Snake(head: pos, body: [head] + snake.body, direction: snake.direction)
    }
    
    func changedDirection(to newDirection: Direction) -> Snake {
        return Snake(head: snake.head, body: snake.body, direction: newDirection)
    }
}
