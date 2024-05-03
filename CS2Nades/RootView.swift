//
//  ContentView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 2.05.2024.
//

import SwiftUI

struct RootView: View {
    var body: some View {
            VStack {
                TabView {
                    
                    MapsView()
                        .tabItem {
                            Label("Maps", systemImage: "map")
                        }
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                    
                }.tint(.black)
                
            }
    }
}

#Preview {
    RootView()
}
