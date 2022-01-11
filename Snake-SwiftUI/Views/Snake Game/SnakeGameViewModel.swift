//
//  SnakeGameViewModel.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/7/20.
//

import SwiftUI

class SnakeGameViewModel: ObservableObject {
    var score: Int {
        body.count
    }
    
    private var t: Timer.TimerPublisher {
        Timer.publish(every: difficulty.interval, on: RunLoop.main, in: .default)
    }
    
    private(set) var difficulty: Difficulty = .medium
    private(set) var dict: [Int : Set<Int>] = [:]
    private var snek: Snake = Snake(head: .zero, body: [], direction: .right) {
        didSet {
            updateValues()
        }
    }
    
    @Published private(set) var timer = Timer.publish(every: 0.15, on: RunLoop.main, in: .default).autoconnect()
    @Published private(set) var body: [Position] = []
    @Published private(set) var isDead: Bool = false
    @Published private(set) var apple: Position = .invalid
    @Published var boardHeight = Int(Difficulty.medium.rawValue)
    
    
    init(difficulty: Difficulty, snake: Snake? = nil) {
        updateValues()
    }
    
    func move(in bounds: Bounds) {
        let newHead = snek.head.next(in: snek.direction)
        
        if newHead == apple {
            snek = snek.grow()
        } else {
            snek = snek.move()
        }
    }
    
    func startNewGame(difficulty: Difficulty, snake: Snake? = nil) {
        self.difficulty = difficulty
        
        let startValue = Int(difficulty.rawValue / 2)
        let initialSnake = snake ?? Snake(head: Position(x: startValue, y: startValue), body: [Position(x: startValue, y: startValue - 1)], direction: .up)
        
        self.snek = initialSnake
        self.timer = t.autoconnect()
    }
    
    func changeDirection(to newDirection: Direction) {
        snek = snek.direction(newDirection)
    }
    
    func color(at position: Position) -> Color {
        if dict[position.y]?.contains(position.x) ?? false {
            return isDead ? .red : .gray
        } else {
            return position == apple ? .green : .black
        }
    }
    
    private func updateValues() {
        body = snek.fullBody
        dict = generateDictionary()
        isDead = !(snek.head.isWithinBounds(for: difficulty) && snek.isValid)
        
        while !apple.isWithinBounds(for: difficulty) || snek.fullBody.contains(apple) {
            apple = Position.randomPosition(for: difficulty)
        }
    }
    
    private func generateDictionary() -> [Int : Set<Int>] {
        var dict = [Int : Set<Int>]()
        
        for appendage in body {
            var set = (dict[appendage.y] ?? [])
            set.insert(appendage.x)
            dict[appendage.y] = set
        }
        
        return dict
    }
}
