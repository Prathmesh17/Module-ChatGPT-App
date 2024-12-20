//
//  ModuleChatGPTApp.swift
//  ModuleChatGPT
//
//  Created by Prathmesh Parteki on 21/12/23.
//

import SwiftUI

@main
struct ModuleChatGPTApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView : View {
    @ObservedObject private var model = AppModel()
    var body: some View {
        TabView {
            ModulesView()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Modules")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(model)
        .onAppear{
            model.setup()
        }
        .preferredColorScheme(model.displayModeString == "System" ? .none : (model.displayModeString == "Dark" ? .dark : .light))
    }
}
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
