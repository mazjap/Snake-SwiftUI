//
//  SnakeGameViewModel.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/7/20.
//

import Foundation

class SnakeGameViewModel: ObservableObject {
    let difficulty: Difficulty
    let timer = Timer.publish(every: 2, on: RunLoop.main, in: .default).autoconnect()
    
    private var snek: Snake {
        didSet {
            updateValues()
        }
    }
    
    @Published var body: [Position] = []
    @Published var score: Int = 0
    @Published var isDead: Bool = false
    private(set) var dict: [UInt : Set<UInt>] = [:]
    
    init(difficulty: Difficulty, snake: Snake? = nil) {
        let startValue = difficulty.rawValue / 2
        
        let initialSnake = snake ?? Snake(head: Position(x: startValue, y: startValue), body: [Position(x: startValue, y: startValue - 1)], direction: .up)
        
        self.difficulty = difficulty
        
        self.snek = initialSnake
        updateValues()
    }
    
    func move() {
        snek = snek.move()
    }
    
    private func updateValues() {
        body = snek.fullBody
        score = body.count
        isDead = !(snek.head.isWithinBounds(for: difficulty) && snek.isValid)
        dict = generateDictionary()
    }
    
    private func generateDictionary() -> [UInt : Set<UInt>] {
        var dict = [UInt : Set<UInt>]()
        
        for appendage in body {
            var set = (dict[appendage.y] ?? [])
            set.insert(appendage.x)
            dict[appendage.y] = set
        }
        
        return dict
    }
}
