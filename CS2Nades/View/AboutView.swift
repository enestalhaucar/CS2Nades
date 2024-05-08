//
//  AboutView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 6.05.2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("APP INFO") {
                        Text("CS2Nade")
                    }
                    Section("Images") {
                        Text("Image Sources")
                        Link("counterstrike.fandom.com", destination: (URL(string: "counterstrike.fandom.com") ?? URL(string: "google.com"))!)
                    }
                    
                    
                }
            }.navigationTitle("About")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AboutView()
}
