//
//  SegmentedPicker.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/20/21.
//

import SwiftUI

extension SegmentedPicker {
    class ViewModel: ObservableObject {
        @Published var selectedIndex: Int
        
        init(index: Int = 0) {
            self.selectedIndex = index
        }
    }
}

struct SegmentedPicker: View {
    
    // MARK: - State
    
    @ObservedObject private var viewModel: SegmentedPicker.ViewModel
    
    // MARK: - Variables
    
    let items: [String]
    let selectionIndicatorColor: Color
    let textColor: Color
    
    // MARK: - Inits
    
    init(viewModel: ViewModel? = nil) {
        self.init(vm: viewModel ?? .init(index: 0))
    }
    
    fileprivate init(
        vm: ViewModel,
        items: [String] = [],
        textColor: Color = .black,
        selectionIndicatorColor: Color = SegmentedPicker.defaultSelectedColor
    ) {
        self._viewModel = .init(wrappedValue: vm)
        self.items = items
        self.textColor = textColor
        self.selectionIndicatorColor = selectionIndicatorColor
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            ForEach(0..<items.count) { i in
                item(at: i)
            }
        }
        .backgroundPreferenceValue(SegmentedBoundsPreferenceKey.self, selectionIndicator(_:))
        .accentColor(textColor)
    }
    
    // MARK: - Private Functions
    
    private func item(at index: Int) -> some View {
        Button(action: {
            guard index >= 0, index < items.count else { return }
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 1)) {
                viewModel.selectedIndex = index
            }
        }) {
            Text(items[index])
                .padding(.vertical, 5)
        }
        .anchorPreference(key: SegmentedBoundsPreferenceKey.self, value: .bounds) {
            viewModel.selectedIndex == index ? $0 : nil
        }
    }
    
    @ViewBuilder
    private func selectionIndicator(_ bounds: Anchor<CGRect>?) -> some View {
        if let bounds = bounds {
            GeometryReader { geometry in
                let frame = geometry[bounds]
                
                selectionIndicatorColor
                    .cornerRadius(8)
                    .frame(width: frame.width + 10, height: frame.height)
                    .offset(x: frame.minX - 5, y: 0)
                    
            }
            .zIndex(0)
        }
    }
    
    static let defaultSelectedColor = Color.blue
}

extension SegmentedPicker {
    func segment(items: [String]) -> Self {
        Self(
            vm: viewModel,
            items: items,
            textColor: textColor,
            selectionIndicatorColor: selectionIndicatorColor
        )
    }
    
    func indicatorColor(_ color: Color) -> Self {
        Self(
            vm: viewModel,
            items: items,
            textColor: textColor,
            selectionIndicatorColor: color
        )
    }
    
    func foregroundColor(_ color: Color) -> Self {
        Self(
            vm: viewModel,
            items: items,
            textColor: color,
            selectionIndicatorColor: selectionIndicatorColor
        )
    }
}

struct SegmentedBoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    
    static var defaultValue: Value = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}


struct SegPreviews: PreviewProvider {
    @State static var index = 0
    
    static var previews: some View {
        SegmentedPicker()
            .segment(items: ["One", "Three", "Two"])
            .foregroundColor(.purple)
    }
}
