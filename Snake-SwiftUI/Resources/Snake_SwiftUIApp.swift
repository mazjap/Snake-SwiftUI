//
//  Snake_SwiftUIApp.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 12/6/20.
//

import SwiftUI

@main
struct Snake_SwiftUIApp: App {
    @State private var selectedIndex = 0
    
    var body: some Scene {
        WindowGroup {
            RootApplication()
        }
    }
}
