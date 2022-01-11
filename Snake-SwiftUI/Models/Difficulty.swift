//
//  Difficulty.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/8/21.
//

import Foundation

enum Difficulty: UInt, CaseIterable {
    case large = 41
    case medium = 31
    case small = 21
    
    var stringValue: String {
        switch self {
        case .large:
            return "Large"
        case .medium:
            return "Medium"
        case .small:
            return "Small"
        }
    }
    
    var interval: Double {
        switch self {
        case .large:
            return 0.1
        case .medium:
            return 0.11
        case .small:
            return 0.12
        }
    }
}
