//
//  MapView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 3.05.2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MapViewModel : ObservableObject {
    
    @Published var lineUpArrayReaded : [LineUp] = []
    
    func loadLineUps(mapName : String) async throws {
        let loadedLineUp = try await MapManager.shared.getLineUps(mapName: mapName)
        
        lineUpArrayReaded = loadedLineUp
    }
}


struct MapView: View {
    
    let navigationTitle : String
    let map : Maps
    @StateObject private var vm = MapViewModel()
    
    
    
    
    var body: some View {
        
            VStack {
                    
                    HStack {
                        VStack {
                            AsyncImage(url: URL(string: map.overview)) { returnedImage in
                                returnedImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.leading)
                                
                                
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text("\(map.name) Overview")
                                .font(.subheadline)
                                .offset(x: 0, y: -10)
                        }
                        
                        VStack {
                            Image(map.logoPhotoName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .scaleEffect(CGSize(width: 0.75, height: 0.75))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.trailing)
                            
                            Text("\(map.name) Logo")
                                .font(.subheadline)
                                .offset(x: 0, y: -10)
                            
                        }
                    }.padding(.horizontal)
                    
                    List {
                        if !vm.lineUpArrayReaded.isEmpty {
                            Section("Smokes") {
                                ForEach(0..<vm.lineUpArrayReaded.count, id: \.self) { index1 in
                                    NavigationLink(value: vm.lineUpArrayReaded[index1]) {
                                        Text(vm.lineUpArrayReaded[index1].name)
                                    }
                                }
                            }
                        } else {
                            Text("There is no LineUp")
                            
                        }
                        
                    }
                }.navigationDestination(for: LineUp.self, destination: { index in
                    LineUpView(urlString: index.youtubeURL)
                })
                .onAppear {
                    Task {
                        try? await vm.loadLineUps(mapName: map.photoName)
                    }
                }
            .navigationTitle(navigationTitle)
        }
        }
    



#Preview {
    NavigationStack {
        MapView(navigationTitle: "Ancient", map: Maps(name: "Ancient", photoName: "ancient", logoPhotoName: "ancient_logo", isActive: true, overview: "https://firebasestorage.googleapis.com/v0/b/cs2nades-bfbb7.appspot.com/o/overview%2Fvertigo_overview.png?alt=media&token=55a99282-3b1f-4de2-86f2-e508e5d02525"))
    }
}
