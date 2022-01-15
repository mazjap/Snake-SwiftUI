//
//  Snake_SwiftUIApp.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/6/20.
//

import SwiftUI

#if os(macOS)
import Cocoa
#endif

@main
struct Snake_SwiftUIApp: App {
    @StateObject private var snakeViewModel = SnakeGameViewModel(difficulty: .medium)
    @StateObject private var selectedIndexVm: SegmentedPicker.ViewModel = .init()
    @StateObject private var multiplayerViewModel: MultiplayerViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            Text("Loading...") // Throw away view
                .frame(idealWidth: .infinity, idealHeight: .infinity)
                .withHostingWindow { window in
                    guard let window = window else { fatalError("Could not attach to window") }
                    
                    window.rootViewController = KeyHostingController(
                        currentKeyCode: .init(
                            get: {
                                nil
                            },
                            set: {
                                let direction: Direction
                                
                                switch $0 {
                                case .keyboardUpArrow, .keyboardW:
                                    direction = .up
                                case .keyboardLeftArrow, .keyboardA:
                                    direction = .left
                                case .keyboardDownArrow, .keyboardS:
                                    direction = .down
                                case .keyboardRightArrow, .keyboardD:
                                    direction = .right
                                default:
                                    return
                                }
                                
                                snakeViewModel.changeDirection(to: direction)
                            }
                        ),
                        allowedKeys: .wasd.withInsertedElements(.arrows),
                        rootView: RootApplication()
                            .environmentObject(snakeViewModel)
                            .environmentObject(selectedIndexVm)
                            .environmentObject(multiplayerViewModel)
                    )
                }
        }
    }
}
