//
//  MapsView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 2.05.2024.
//

import SwiftUI

@MainActor
final class mapsViewModel : ObservableObject {
    @Published private(set) var maps : [Maps]? = nil
    
    let mapNames : [String] = ["ancient", "dust2"]
    
    func loadMap() async throws {
        for mapName in mapNames {
            let loadedMap = try await MapManager.shared.getData(mapName: mapName)
            maps?.append(loadedMap)
            print(maps as Any)
        }
        
        
    }
}

struct MapsView: View {
    @StateObject private var vm = mapsViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ForEach(0..<vm.mapNames.count) { index in
                        Text(vm.maps?[index].name ?? "anal")
                    }
                }.task {
                    try? await vm.loadMap()
                }
            }.navigationTitle("Maps")
        }
    }
}

#Preview {
    MapsView()
}
