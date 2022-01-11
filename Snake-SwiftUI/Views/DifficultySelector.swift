//
//  DifficultySelector.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 6/9/21.
//

import SwiftUI

struct DifficultySelector: View {
    @ObservedObject private var selectedIndexVm: SegmentedPicker.ViewModel
    private let didLose: Bool
    private let score: Int
    private let action: (Difficulty) -> Void
    
    private var titleText: String {
        didLose ? "\(score != 0 ? "Score: \(score). " : "")Great Job!" : "Snek"
    }
    
    private var buttonText: String {
        didLose ? "Restart" : "Start"
    }
    
    private var selectedDifficulty: Difficulty {
        switch selectedIndexVm.selectedIndex {
        case 0:
            return .large
        case 1:
            return .medium
        default:
            return .small
        }
    }
    
    init(selectedIndexVm: SegmentedPicker.ViewModel? = nil, score: Int? = nil, didLose: Bool? = nil, startAction: @escaping (Difficulty) -> Void) {
        self.didLose = didLose ?? false
        self.score = score ?? 0
        self.action = startAction
        self._selectedIndexVm = .init(wrappedValue: selectedIndexVm ?? .init())
    }
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 50) {
                Text(titleText)
                    .font(.largeTitle)
                    .bold()
                HStack {
                    Spacer()
                    
                    ZStack(alignment: .top) {
                        VStack(spacing: 16) {
                            VStack(spacing: 4) {
                                Text("Map Size:")
                                    .font(.headline)
                                
                                SegmentedPicker(viewModel: selectedIndexVm)
                                    .segment(items: Difficulty.allCases.map(\.stringValue))
                                    .indicatorColor(.gray)
                                    .foregroundColor(.white)
                            }
                                
                            
                            Button {
                                action(selectedDifficulty)
                            } label: {
                                Text(buttonText)
                                    .foregroundColor(.black)
                                    .bold()
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color.white)
                                    .cornerRadius(8)
                            }
                        }
                        
                        // TODO: Settings page to set theme (filled or outlined)
//                        HStack {
//                            Spacer()
//
//                            Button(action: {
//
//                            }, label: {
//                                Image(systemName: "gearshape.fill")
//                            })
//                        }
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .font(.title3)
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(Color.black)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
        .cornerRadius(8)
    }
}

struct DifficultySelector_Previews: PreviewProvider {
    static var previews: some View {
        DifficultySelector(startAction: {_ in})
    }
}
