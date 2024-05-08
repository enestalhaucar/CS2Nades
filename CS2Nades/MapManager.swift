//
//  MapManager.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 2.05.2024.
//

import Foundation
import FirebaseFirestore

struct Maps : Identifiable, Hashable {
    var id: String = UUID().uuidString
    let name : String
    let photoName : String
    let logoPhotoName : String
    let isActive : Bool
    let overview : String
}

struct LineUp : Hashable {
    var id: String = UUID().uuidString
    let name : String
    let to : String
    let youtubeURL : String
}

final class MapManager {
    static let shared = MapManager()
    private init() {}
    
    let db = Firestore.firestore()
    
    
    

    
    func getData(mapName : String) async throws -> Maps {
        let snapshot = try await db.collection("maps").document(mapName).getDocument()
        
        
        guard let data = snapshot.data() else {
            throw URLError(.badURL)
        }
        
        let mapName = data["name"] as! String
        let mapPhotoName = data["photoName"] as! String
        let mapLogoPhotoName = data["logoPhotoName"] as! String
        let mapIsActive = data["isActive"] as! Bool
        let mapOverview = data["overview"] as! String
        
        
        return Maps(id: UUID().uuidString, name: mapName, photoName: mapPhotoName, logoPhotoName: mapLogoPhotoName, isActive: mapIsActive, overview: mapOverview)
        
    }
    
    func getLineUps(mapName : String) async throws -> [LineUp] {
        
        var lineUps : [LineUp] = []
        
        let snapshot = try await db.collection("maps").document(mapName).collection("lineups").getDocuments()
        
        for document in snapshot.documents {
                if let data = document.data() as? [String: Any] {
                    let lineUpName = data["name"] as! String
                    let lineUpTo = data["to"] as! String
                    let lineUpURL = data["youtubeURL"] as! String
                    
                    let lineUp = LineUp(name: lineUpName, to: lineUpTo, youtubeURL: lineUpURL)
                    lineUps.append(lineUp)
                } else {
                    throw URLError(.badURL)
                }
            }
        
        
       
        return lineUps
        
    }
}
