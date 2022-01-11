//
//  AttributedText.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/26/21.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let strokeWidth: CGFloat
    let textColor: Color
    let strokeColor: Color
    
    init(text: String, strokeWidth: CGFloat = 0.5, textColor: Color = .black, strokeColor: Color = .white) {
        self.text = text
        self.strokeWidth = strokeWidth
        self.textColor = textColor
        self.strokeColor = strokeColor
    }

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x: strokeWidth, y: strokeWidth)
                Text(text).offset(x: -strokeWidth, y: -strokeWidth)
                Text(text).offset(x: -strokeWidth, y: strokeWidth)
                Text(text).offset(x: strokeWidth, y: -strokeWidth)
            }
            .foregroundColor(strokeColor)
            Text(text)
                .foregroundColor(textColor)
        }
    }
}

struct AttributedText: View {
    typealias AttrStringKVO = [NSAttributedString.Key : Any]
    
    @State private var size: CGSize = .zero
    private var attributes: AttrStringKVO = [:]
    
    @Binding private var text: String
    
    init(_ text: String) {
        self.init(binding: .init(get: { return text }, set: { _ in }))
    }
    
    init(_ binding: Binding<String>) {
        self.init(binding: binding)
    }
    
    fileprivate init(binding: Binding<String>, attributes: AttrStringKVO = [:]) {
        self._text = binding
        self.attributes = attributes
    }
    
    var body: some View {
        AttributedTextRepresentable(text: $text, attributes: attributes, size: $size)
            .frame(width: size.width, height: size.height)
        
    }
}

extension AttributedText {
    struct AttributedTextRepresentable: UIViewRepresentable {
        @Binding private var text: String
        @Binding private var size: CGSize
        private let attributes: AttrStringKVO
        
        fileprivate init(text: Binding<String>, attributes: AttrStringKVO, size: Binding<CGSize>) {
            self._text = text
            self._size = size
            self.attributes = attributes
        }
        
        func makeUIView(context: Context) -> UILabel {
            let label = UILabel()
            
            label.lineBreakMode = .byClipping
            label.numberOfLines = 0
            label.textAlignment = .center
            
            return label
        }
        
        func updateUIView(_ uiView: UILabel, context: Context) {
            uiView.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    }
}

extension AttributedText {
    func withAttribute(_ key: NSAttributedString.Key, value: Any) -> Self {
        var attrs = attributes
        attrs[key] = value
        
        return .init(binding: $text, attributes: attrs)
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText("Hello")
            .withAttribute(.foregroundColor, value: UIColor.red)
            .withAttribute(.font, value: UIFont.systemFont(ofSize: 30))
    }
}
