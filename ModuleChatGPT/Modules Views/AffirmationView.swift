//
//  AffirmationView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 22/12/23.
//

import SwiftUI

struct AffirmationView: View {
    @EnvironmentObject private var model:AppModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 32){
                if model.isEmptyAffirmationScreen{
                    Text("Tap 'Generate' in the top right corner of your screen")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                if model.isThinking {
                    VStack {
                        Text("Generating affirmation...")
                        ProgressView().progressViewStyle(.circular)
                    }
                }
                
                if model.hasResultAffirmationScreen {
                    ResultView(generatedText: model.generatedAffirmation)
                }
            }
            .padding(.vertical,32)
            .navigationTitle("Affirmation")
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
                    if !model.generatedAffirmation.isEmpty {
                        Button("Reset"){
                            model.generatedAffirmation = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate"){
                    model.makeAffirmation()
                }
                .disabled(model.isThinking)
            }
        }
    }
}

#Preview {
    AffirmationView()
}
