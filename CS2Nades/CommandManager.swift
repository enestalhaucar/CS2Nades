//
//  CommandManager.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 3.05.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Command : Hashable, Identifiable {
    var id : String = UUID().uuidString
    let commandName : String
    let commandExplanation : String
}

final class CommandManager {
    static let shared = CommandManager()
    private init() {}
    
    let db = Firestore.firestore()
    
    func getCommands(commandTitle : String) async throws -> [Command] {
        let snapshot = try await db.collection(commandTitle).getDocuments()
        
        var commands : [Command] = []
        
        for document in snapshot.documents {
            if let data = document.data() as? [String: Any]{
                let commandName = data["command"] as! String
                let commandExplanation = data["explanation"] as! String
                
                let command = Command(commandName: commandName, commandExplanation: commandExplanation)
                commands.append(command)
                
            } else {
                throw URLError(.badURL)
            }
        }
        return commands
        
    }
}
