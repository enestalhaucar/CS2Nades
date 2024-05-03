//
//  MapManager.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 2.05.2024.
//

import Foundation
import FirebaseFirestore

struct Maps : Identifiable{
    var id: String = UUID().uuidString
    let name : String
    let photoName : String
    let logoPhotoName : String
    let isActive : Bool
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
        
        
        return Maps(id: UUID().uuidString, name: mapName, photoName: mapPhotoName, logoPhotoName: mapLogoPhotoName, isActive: mapIsActive)
        
    }
}
