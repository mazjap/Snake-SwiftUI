////
////  KeyListenerView.swift
////  Snake-SwiftUI
////
////  Created by Jordan Christensen on 1/13/22.
////
//
//import SwiftUI
//
//extension View {
//    func listenForDirectionChanges(action: @escaping (Direction) -> Void) -> some View {
//        ZStack {
//            self
//
//            KeyListenerView(direction: .init(get: { nil }, set: { if let dir = $0 { action(dir) } }))
//                .frame(idealWidth: .infinity, idealHeight: .infinity)
//                .allowsHitTesting(false)
//
//        }
//    }
//}
//
//// Listen for and map keyboard presses to directions
//struct KeyListenerView: UIViewRepresentable {
//    @Binding private var direction: Direction?
//
//    init(direction: Binding<Direction?>) {
//        self._direction = direction
//    }
//
//    func makeUIView(context: Context) -> UIListener {
//        let listener = UIListener()
//
//        updateUIView(listener, context: context)
//
//        return listener
//    }
//
//    func updateUIView(_ listener: UIListener, context: Context) {
//        listener.delegate = context.coordinator
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(direction: $direction)
//    }
//}
//
//extension KeyListenerView {
//    class UIListener: UIView {
//        override var isFirstResponder: Bool { true }
//        override var canBecomeFirstResponder: Bool { true }
//        override var canBecomeFocused: Bool { true }
//        weak var delegate: DirectionListenerDelegate?
//
//        override var keyCommands: [UIKeyCommand]? {
//            [
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: UIKeyCommand.inputUpArrow), // up
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: "w"),
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: UIKeyCommand.inputLeftArrow), // left
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: "a"),
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: UIKeyCommand.inputDownArrow), // down
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: "s"),
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: UIKeyCommand.inputRightArrow), // right
//                UIKeyCommand(action: #selector(keyboardButtonPressed(_:)), input: "d")
//            ]
//        }
//
//        @objc
//        private func keyboardButtonPressed(_ sender: UIKeyCommand) {
//            print("UIKeyCommand buttonPressed called: \(sender.input ?? "nil")")
//            guard let delegate = delegate else { return }
//
//            switch sender.input {
//            case "w", UIKeyCommand.inputUpArrow:
//                delegate.directionChanged(to: .up)
//            case "a", UIKeyCommand.inputLeftArrow:
//                delegate.directionChanged(to: .left)
//            case "s", UIKeyCommand.inputDownArrow:
//                delegate.directionChanged(to: .down)
//            case "d", UIKeyCommand.inputRightArrow:
//                delegate.directionChanged(to: .right)
//            default:
//                delegate.directionChanged(to: nil)
//            }
//        }
//
//        override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
//            print("UIView pressesBegan called: \(presses.first?.key?.characters ?? "nil")")
//            guard let delegate = delegate, let key = presses.first?.key else { return }
//
//            let newDirection: Direction?
//
//            switch key.keyCode {
//            case .keyboardUpArrow, .keyboardW:
//                newDirection = .up
//            case .keyboardLeftArrow, .keyboardA:
//                newDirection = .left
//            case .keyboardDownArrow, .keyboardS:
//                newDirection = .down
//            case .keyboardRightArrow, .keyboardD:
//                newDirection = .right
//            default:
//                newDirection = nil
//                super.pressesEnded(presses, with: event)
//            }
//
//            if let newDirection = newDirection {
//                delegate.directionChanged(to: newDirection)
//            }
//        }
//    }
//
//    class Coordinator: DirectionListenerDelegate {
//        @Binding private var direction: Direction?
//
//        init(direction: Binding<Direction?>) {
//            self._direction = direction
//        }
//
//        func directionChanged(to direction: Direction?) {
//            DispatchQueue.main.async { // Wait for next event cycle (just in case)
//                self.direction = direction
//            }
//        }
//    }
//}
//
//protocol DirectionListenerDelegate: AnyObject {
//    func directionChanged(to direction: Direction?)
//}


//
//  KeyListenerView.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 1/13/22.
//

import SwiftUI

extension UIKey {
    var desc: String {
        switch keyCode {
        case .keyboardDownArrow:
            return "Down Arrow"
        case .keyboardUpArrow:
            return "Up Arrow"
        case .keyboardLeftArrow:
            return "Left Arrow"
        case .keyboardRightArrow:
            return "Right Arrow"
        default:
            return characters
        }
    }
}

class KeyHostingController<Content>: UIHostingController<Content> where Content: View {
    @Binding private var currentKey: UIKeyboardHIDUsage?
    
    private var keyCodesToHandle: Set<UIKeyboardHIDUsage>?
    
    init(currentKeyCode: Binding<UIKeyboardHIDUsage?>, allowedKeys: Set<UIKeyboardHIDUsage>? = nil, rootView: Content) {
        self._currentKey = currentKeyCode
        self.keyCodesToHandle = allowedKeys
        super.init(rootView: rootView)
    }
    
    @MainActor
    @objc
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) will not be implemented")
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        print("UIView pressesBegan called: " + (presses.first?.key?.desc ?? "nil"))
        guard let key = presses.first?.key?.keyCode,
              keyCodesToHandle?.contains(key) ?? true
        else { return }
        
        currentKey = presses.first?.key?.keyCode
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let key = presses.first?.key?.keyCode,
              keyCodesToHandle?.contains(key) ?? true
        else { return }
        
        currentKey = nil
    }
}
