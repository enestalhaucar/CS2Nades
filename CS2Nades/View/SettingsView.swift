//
//  SettingsView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 3.05.2024.
//

import SwiftUI

struct SettingsView: View {
    var boldtext = Text("CS2Nade").fontWeight(.bold)
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("About CS2Nade") {
                        NavigationLink(destination: AboutView(), label: {
                            Text("About \(boldtext)")
                        })
                        Text("Recommend \(boldtext) to Friends")
                    }
                    Section("Terms") {
                        Text("Terms of Use")
                        Text("Privacy Policy")
                    }
                    Section("Support") {
                        Text("Contact Me")
                    }
                    
                    
                }.navigationDestination(for: String.self) { value in
                    AboutView()
                }
            }.navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
