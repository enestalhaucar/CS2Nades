//
//  CommandView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 3.05.2024.
//

import SwiftUI

@MainActor
final class CommandViewModel : ObservableObject {
    
    @Published var commandReaded : [[Command]] = []
    
    let commandTitles : [String] = ["launchCommands", "usefulCommands", "practiceCommands", "botCommands"]
    
    func loadCommand() async throws {
        for title in commandTitles {
            let loadedCommands = try await CommandManager.shared.getCommands(commandTitle: title)
            commandReaded.append(loadedCommands)
            
            
        }
        
        
        
        print(commandReaded)
        
    }
    
    
}

struct CommandsView: View {
    @StateObject private var vm = CommandViewModel()
    
    var body: some View {
        NavigationStack() {
            VStack {
                List {
                    if !vm.commandReaded.isEmpty {
                        ForEach(0..<vm.commandTitles.count, id: \.self) { index in
                            NavigationLink(value: index) {
                                Text(vm.commandTitles[index].capitalized)
                            }
                        }
                    }
                    else {
                        Text("There is no data")
                    }
                }
                
                
            }.navigationDestination(for: Int.self) { index in
                CommandView(navigationTitle: vm.commandTitles[index].capitalized, commandReaded: vm.commandReaded[index])
            }
            .onAppear {
                Task {
                    try? await vm.loadCommand()
                    
                }
            }.navigationTitle("Commands")
        }
    }
}

#Preview {
    CommandsView()
}
