//
//  CommandView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 3.05.2024.
//

import SwiftUI


final class CommandViewModel : ObservableObject {
    
    @Published private var commandReaded : [Command] = []
    
    func loadCommand() async throws {
        let loadedCommand = CommandManager.shared.getCommands(commandType: <#T##String#>)
        
    }
    
}

struct CommandView: View {
    @State private var vm = CommandViewModel()
    var body: some View {
        VStack {
            List {
                
            }
        }
    }
}

#Preview {
    CommandView()
}
