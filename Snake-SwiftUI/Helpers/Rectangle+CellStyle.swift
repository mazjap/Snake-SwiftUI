//
//  Rectangle+CellStyle.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 10/7/21.
//

import SwiftUI

extension Rectangle {
    @ViewBuilder
    func cellStyle(_ style: CellStyle, color: Color) -> some View {
        switch style {
        case let .outline(width):
            self.border(color, width: width)
        case .filled:
            self.foregroundColor(color)
//            color.overlay(self)
        }
    }
}
