//
//  SnakeGame.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/6/20.
//

import SwiftUI

struct SnakeGame: View {
    @ObservedObject private var vm: SnakeGameViewModel
    
    init(vm: SnakeGameViewModel? = nil) {
        self._vm = ObservedObject<SnakeGameViewModel>(wrappedValue: vm ?? SnakeGameViewModel(difficulty: .normal))
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let size = geometry.size.width / CGFloat(vm.difficulty.rawValue)
                let range: [Int] = (0..<Int(vm.difficulty.rawValue)).reversed()
                
                VStack(alignment: .center, spacing: 0) {
                    ForEach(range, id: \.self) { y in
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(range, id: \.self) { x in
                                Rectangle()
                                    .foregroundColor(color(at: Position(x: UInt(x), y: UInt(y))))
                                    .frame(width: size, height: size)
                            }
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("\(vm.score)")
                }
                
                Spacer()
            }
        }
        .onReceive(vm.timer, perform: { timer in
            if !vm.isDead {
                vm.move()
            }
        })
    }
    
    func color(at position: Position) -> Color {
        if vm.dict[position.y]?.contains(position.x) ?? false {
            if vm.isDead {
                return .red
            } else {
                return .gray
            }
        } else {
            return .black
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SnakeGame()
    }
}
