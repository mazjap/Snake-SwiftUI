//
//  Set<UIKeyboardHIDKey>+Extension.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 1/14/22.
//

import UIKit

extension Set where Element == UIKeyboardHIDUsage {
    static let wasd: Self = [.keyboardW, .keyboardA, .keyboardS, .keyboardD]
    static let arrows: Self = [.keyboardUpArrow, .keyboardLeftArrow, .keyboardDownArrow, .keyboardRightArrow]
}

extension Set {
    func withInsertedElement(_ element: Element) -> Self {
        withInsertedElements([element])
    }
    
    func withInsertedElements(_ set: Set<Element>) -> Self {
        var copy = self
        
        for element in set {
            copy.insert(element)
        }
        
        return copy
    }
}
