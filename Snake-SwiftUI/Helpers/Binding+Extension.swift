//
//  Binding+Extension.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 1/13/22.
//

import SwiftUI

extension Binding {
    func onChanged(perform action: @escaping (Value) -> Void) -> Self {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                wrappedValue = newValue
                action(newValue)
            }
        )
    }
    
    init(_ staticValue: Value) {
        self.init(
            get: { staticValue },
            set: { _ in }
        )
    }
}

func logErrorIntro(file: String = #file, line: UInt = #line) {
    print("Error: f-\(file) l-\(line)")
}

func NSError(_ error: Error, file: String = #file, line: UInt = #line) {
    logErrorIntro(file: file, line: line)
    print("\tMessage: \(error)")
}

func NSError(_ message: String, file: String = #file, line: UInt = #line) {
    logErrorIntro(file: file, line: line)
    print("\tMessage: \(message)")
}
