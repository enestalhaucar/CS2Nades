//
//  CommandView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 5.05.2024.
//

import SwiftUI

struct CommandView: View {
    var navigationTitle : String
    var commandReaded : [Command]
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(0..<commandReaded.count, id: \.self) { index in
                        Text(commandReaded[index].commandName)
                        Text(commandReaded[index].commandExplanation)
                    }
                }
            }.navigationTitle("Commands")
        }
        
    }
}

#Preview {
    CommandView(navigationTitle: "title", commandReaded: [Command(id: "aaaaaa", commandName: "noEnes", commandExplanation: "ecplanation")])
}
