//
//  ExpandedView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 22/12/23.
//

import SwiftUI

struct ExpandedView: View {
    @EnvironmentObject private var model : AppModel
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32){
                    VStack {
                        HStack {
                            TextField("Required",text: $model.expandedEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                                .padding(.horizontal,24)
                            if model.expandedEntryText.isEmpty {
                                Button("Paste"){
                                    model.expandedEntryText = UIPasteboard.general.string ?? ""
                                }
                            }
                        }
                        .padding(.trailing,24)
                        Text("Provide text")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,34)
                    }
                    if model.isEmptyExpandedScreen, !model.expandedEntryText.isEmpty {
                        Text("Tap 'Generate' in the top right corner of your screen")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    if model.isThinking {
                        VStack {
                            Text("Generating response...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    
                    if model.hasResultExpandedScreen {
                        ResultView(generatedText: model.generatedExpanded)
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Expand Text")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { screenToolBar }
        }
    }
    private var screenToolBar: some ToolbarContent {
        Group{
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button("Close"){
                        dismiss()
                    }
                    if !model.generatedExpanded.isEmpty {
                        Button("Reset"){
                            model.expandedEntryText = ""
                            model.generatedExpanded = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate"){
                    model.makeExpanded()
                }
                .disabled(model.isThinking || model.expandedEntryText.isEmpty)
            }
        }
    }
}

#Preview {
    ExpandedView()
}
