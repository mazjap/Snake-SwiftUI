//
//  ContentView.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/6/20.
//

import SwiftUI

struct ContentView: View {
    @State private var snek = Snake(head: .zero, body: [.zero], direction: .right)
    
    private var difficulty: Difficulty
    
    init(snake: Snake? = nil, difficulty: Difficulty = .normal) {
        self.difficulty = difficulty
        
        if let snake = snake {
            self.snek = snake
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width / CGFloat(difficulty.rawValue)
            let heightCount = Int(geometry.size.height / size)
            
            HStack {
                ForEach(0..<difficulty.rawValue) { i in
                    VStack {
                        ForEach(0..<heightCount) { j in
                            
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(difficulty: .normal)
    }
}
