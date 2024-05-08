//
//  CommandView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 5.05.2024.
//

import SwiftUI

struct CommandView: View {
    let navigationTitle : String
    let choosedCommandsType : [Command]
    var body: some View {      
            VStack {
                List {
                    Section {
                        ForEach(0..<choosedCommandsType.count, id: \.self) { index in
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(choosedCommandsType[index].commandName)
                                        .fontDesign(.monospaced)
                                        .frame(alignment: .leading)
                                    Text(choosedCommandsType[index].commandExplanation).fontWeight(.regular)
                                }.swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button("Archive") {
                                        
                                    }.tint(.blue)
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button("Add to Favorites") {
                                        
                                    }.tint(.yellow)
                                }
                                
                            }
                        }
                    } header: {
                        Text(navigationTitle)
                    } footer: {
                        Text(navigationTitle)
                    }

                    
                }
            }.navigationTitle(navigationTitle)
    }
}

#Preview {
    NavigationStack {
        CommandView(navigationTitle: "Launch Commands", choosedCommandsType: [Command(id: "aaaaaa", commandType: "Launch Commands", commandName: "sv_Enes", commandExplanation: "explanationexplanationexplanationexplanationexplanationexplanationexplanationexplanationexplanationexplanation"), Command(id: "aaaaaa", commandType: "Launch Commands", commandName: "sv_Enes", commandExplanation: "explanation")])
    }
}
