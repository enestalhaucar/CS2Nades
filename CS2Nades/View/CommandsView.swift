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
        
    }
    
    
}

struct CommandsView: View {
    @State private var dataLoaded = false
    @StateObject private var vm = CommandViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                    if dataLoaded {
                        if !vm.commandReaded.isEmpty {
                            ForEach(0...3, id: \.self) { index in
                                NavigationLink(value: vm.commandReaded[index]) {
                                    Text(vm.commandReaded[index][0].commandType ?? "Default")
                                }
                            }
                        }
                        else {
                            Text("There is no data")
                        }
                    }
                    
                }
                
                
            }.navigationDestination(for: [Command].self, destination: { commands in
                CommandView(navigationTitle: commands.first?.commandType ?? "default", choosedCommandsType: commands)
            })
            .onAppear {
                Task {
                    do {
                        try await vm.loadCommand()
                        dataLoaded = true
                    } catch {
                        print("error while loading command")
                    }
                }
            }.navigationTitle("Commands")
        }
    }
}


#Preview {
    NavigationStack {
        CommandsView()
    }
}
