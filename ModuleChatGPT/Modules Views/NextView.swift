//
//  NextView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 22/12/23.
//

import SwiftUI

struct NextView: View {
    @EnvironmentObject private var model:AppModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 32){
                if model.isEmptyNextScreen{
                    Text("Tap 'Generate' in the top right corner of your screen")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                if model.isThinking {
                    VStack {
                        Text("Generating next...")
                        ProgressView().progressViewStyle(.circular)
                    }
                }
                
                if model.hasResultNextScreen {
                    ResultView(generatedText: model.generatedNext)
                }
            }
            .padding(.vertical,32)
            .navigationTitle("Next")
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
                    if !model.generatedNext.isEmpty {
                        Button("Reset"){
                            model.generatedNext = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate"){
                    model.makeNext()
                }
                .disabled(model.isThinking)
            }
        }
    }
}
#Preview {
    NextView()
}
