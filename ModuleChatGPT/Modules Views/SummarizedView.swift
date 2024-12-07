//
//  SummarizedView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 22/12/23.
//

import SwiftUI

struct SummarizedView: View {
    @EnvironmentObject private var model : AppModel
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32){
                    VStack {
                        HStack {
                            TextField("Required",text: $model.summarizeEntryText, axis: .vertical)
                                .focused($fieldIsFocused)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                                .padding(.horizontal,24)
                            if model.summarizeEntryText.isEmpty {
                                Button("Paste"){
                                    model.summarizeEntryText = UIPasteboard.general.string ?? ""
                                }
                            }
                        }
                        .padding(.trailing,24)
                        Text("Provide a topic of keyword")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,34)
                    }
                    if model.isEmptySummarizedScreen, !model.summarizeEntryText.isEmpty {
                        Text("Tap 'Generate' in the top right corner of your screen")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    if model.isThinking {
                        VStack {
                            Text("Generating summary...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    
                    if model.hasResultSummarizedScreen {
                        ResultView(generatedText: model.generatedSummary)
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Summarize Text")
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
                    if !model.generatedSummary.isEmpty {
                        Button("Reset"){
                            model.summarizeEntryText = ""
                            model.generatedSummary = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate"){
                    model.makeSummary()
                }
                .disabled(model.isThinking || model.summarizeEntryText.isEmpty)
            }
        }
    }
}

#Preview {
    SummarizedView()
}
