//
//  DefinitionView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 22/12/23.
//

import SwiftUI

struct DefinitionView: View {
    @EnvironmentObject private var model : AppModel
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32){
                    VStack {
                        HStack {
                            TextField("Required",text: $model.definitionEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                                .padding(.horizontal,24)
                            if model.definitionEntryText.isEmpty {
                                Button("Paste"){
                                    model.definitionEntryText = UIPasteboard.general.string ?? ""
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
                    if model.isEmptyDefintionScreen, !model.definitionEntryText.isEmpty {
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
                    
                    if model.hasResultDefinitionScreen {
                        ResultView(generatedText: model.generatedDefinition)
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Definition")
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
                    if !model.generatedDefinition.isEmpty {
                        Button("Reset"){
                            model.definitionEntryText = ""
                            model.generatedDefinition = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate"){
                    model.makeDefinition()
                }
                .disabled(model.isThinking || model.definitionEntryText.isEmpty)
            }
        }
    }
}


