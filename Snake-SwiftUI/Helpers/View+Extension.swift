//
//  View+Extension.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 1/13/22.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<TrueTransform, FalseTransform>(_ condition: Bool, @ViewBuilder trueModification: (Self) -> TrueTransform, @ViewBuilder falseModification: (Self) -> FalseTransform) -> some View where TrueTransform: View, FalseTransform: View {
        if condition {
            trueModification(self)
        } else {
            falseModification(self)
        }
    }
    
    @ViewBuilder
    func `if`<O, TrueTransform, FalseTransform>(`let` optional: O?, @ViewBuilder trueModification: (O, Self) -> TrueTransform, @ViewBuilder falseModification: (Self) -> FalseTransform) -> some View where TrueTransform: View, FalseTransform: View {
        if let unwrapped = optional {
            trueModification(unwrapped, self)
        } else {
            falseModification(self)
        }
    }
    
    func `if`<Transform>(_ condition: Bool, @ViewBuilder modification: (Self) -> Transform) -> some View where Transform: View {
        self.if(condition, trueModification: modification, falseModification: { $0 })
    }
    
    func `if`<O, Transform>(`let` optional: O?, @ViewBuilder modification: (O, Self) -> Transform) -> some View where Transform: View {
        self.if(let: optional, trueModification: modification, falseModification: { $0 })
    }
}
