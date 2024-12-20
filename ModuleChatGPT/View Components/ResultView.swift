//
//  ResultView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 21/12/23.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject private var model:AppModel
    
    var generatedText : String
    var textSize : CGFloat
    
    var showCopyButton:Bool
    @Binding var copyButtonTitle:String
    
    init(generatedText:String , textSize:CGFloat = 18,showCopyButton : Bool = false,copyButtonTitle:Binding<String> = Binding.constant("Copy")) {
        self.generatedText = generatedText
        self.textSize = textSize
        self.showCopyButton = showCopyButton
        self._copyButtonTitle = copyButtonTitle
    }
    var body: some View {
        VStack{
            Text(generatedText)
                .font(.system(size: textSize))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .contextMenu {
                    Button {
                        UIPasteboard.general.string = generatedText
                    } label: {
                        Image(systemName: "doc.on.doc")
                        Text("Copy")
                    }
                }
            if showCopyButton {
                Button(copyButtonTitle) {
                    UIPasteboard.general.string = model.generatedConcept
                    copyButtonTitle = "Copied to clipboard!"
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(Color(.secondarySystemFill).cornerRadius(16))
        .padding(.horizontal,16)
    }
}

//#Preview {
//    ResultView()
//}
