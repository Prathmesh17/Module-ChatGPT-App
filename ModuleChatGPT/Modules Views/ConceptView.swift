//
//  ConceptView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 21/12/23.
//

import SwiftUI

struct ConceptView: View {
    @EnvironmentObject private var model:AppModel
    
    @Environment(\.dismiss) var dismiss
    @State private var copyButtonTitle : String = "Copy"
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 32){
                if model.isEmptyNewConceptScreen{
                    Text("Tap 'Generate' in the top right corner of your screen")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                if model.isThinking {
                    VStack {
                        Text("Generating random concept...")
                        ProgressView().progressViewStyle(.circular)
                    }
                }
                
                if model.hasResultNewConceptScreen {
                    ResultView(generatedText: model.generatedConcept,textSize: 28,showCopyButton: true,copyButtonTitle: $copyButtonTitle)
                }
            }
            .padding(.vertical,32)
            .navigationTitle("Random Concept")
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
                    if !model.generatedConcept.isEmpty {
                        Button("Reset"){
                            copyButtonTitle = "Copy"
                            model.generatedConcept = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate"){
                    copyButtonTitle = "Copy"
                    model.makeConcept()
                }
                .disabled(model.isThinking)
            }
        }
    }
}

#Preview {
    ConceptView()
}
