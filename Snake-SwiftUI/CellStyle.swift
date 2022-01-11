//
//  CellStyle.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/23/21.
//

import SwiftUI

enum CellStyle {
    case fill
    case border(CGFloat)
}

struct CellStyleModifier: ViewModifier {
    let style: CellStyle
    let color: Color
    
    func body(content: Content) -> some View {
        switch style {
        case .fill:
            content.foregroundColor(color)
        case let .border(width):
            content.border(color, width: width)
        }
    }
}

extension Rectangle {
    func cellStyle(_ style: CellStyle, color: Color) -> some View {
        self.modifier(CellStyleModifier(style: style, color: color))
    }
}
