//
//  SettingsView.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 21/12/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var model : AppModel
    
    let displayOptions = ["Light","Dark","System"]
    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    Picker("Display", selection: $model.displayModeString) {
                        ForEach(displayOptions,id: \.self){
                            Text($0)
                        }
                    }
                }
                Section("Contact"){
                    Button{
                        EmailHelper.shared.sendEmail(subject:"ModulesGPT v\(AppInfo.versionNumber)",body:"",to:AppInfo.supportEmail)
                    }label: {
                        Label("Email Support",systemImage: "tray.full.fill")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}


