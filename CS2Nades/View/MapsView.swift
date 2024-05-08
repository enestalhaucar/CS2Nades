//
//  MapsView.swift
//  CS2Nades
//
//  Created by Enes Talha Uçar  on 2.05.2024.
//

import SwiftUI

@MainActor
final class mapsViewModel : ObservableObject {
    @Published var maps : [Maps] = []
    
    
    
    let mapNames : [String] = ["ancient", "dust2", "overpass", "inferno", "mirage", "anubis", "nuke", "vertigo"]
    
    func loadMap() async throws {
        for mapName in mapNames {
            let loadedMap = try await MapManager.shared.getData(mapName: mapName)
            maps.append(loadedMap)
        }
    }
}

enum FilterType {
    case all
    case active
    case reserve
}

struct MapsView: View {
    @StateObject private var vm = mapsViewModel()
    @State private var currentIndex: Int = 0
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    @GestureState private var dragOffset: CGFloat = 0
    @State private var selectedFilter: FilterType = .all
    @State private var selectedMapIndex : Int? = nil
    @State private var path : [Maps] = []
    
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                pickerSection
                
                ZStack {
                    if !vm.maps.isEmpty {
                        ForEach(0..<filteredMaps.count, id: \.self) { index in
                            ZStack {
                                Image("\(filteredMaps[index].photoName)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width * 9 / 10, height: height / 1.59)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .opacity(currentIndex == index ? 1.0 : 0)
                                    .scaleEffect(currentIndex == index ? 1 : 0.8)
                                    .offset(x: CGFloat(index - currentIndex) * 300, y: 0)
                                HStack {
                                    Image("\(filteredMaps[index].logoPhotoName)")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .padding(.trailing,5)
                                    
                                    NavigationLink(value: filteredMaps[index]) {
                                        Text(filteredMaps[index].name)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                    }
                                    .navigationDestination(for: Maps.self) { value in
                                        MapView(navigationTitle: value.name, map: value)
                                       
                                    }
                                }
                                .frame(width: width * 0.6 , height: height / 2, alignment: .bottomLeading)
                                .offset(x: CGFloat(index - currentIndex) * 500 , y: 0)
                                
                            }
                            .gesture(
                                DragGesture()
                                    .onEnded({ value in
                                        let threshold: CGFloat = 50
                                        if value.translation.width > threshold {
                                            withAnimation {
                                                currentIndex = max(0, currentIndex - 1)
                                            }
                                        } else if value.translation.width < -threshold {
                                            withAnimation {
                                                currentIndex = min(filteredMaps.count - 1, currentIndex + 1)
                                            }
                                        }
                                    })
                            )
                            
                        }
                    }
                }
                
                
                Spacer()
            }
            .navigationTitle("Maps")
            .onAppear {
                Task {
                    do {
                        try await vm.loadMap()
                    } catch {
                        print("error loadMap")
                    }
                }
            }
        }
    }
    
    var filteredMaps: [Maps] {
        switch selectedFilter {
        case .all:
            return vm.maps
        case .active:
            return vm.maps.filter { $0.isActive }
        case .reserve:
            return vm.maps.filter { !$0.isActive }
        }
    }
}


#Preview {
    MapsView()
}


extension MapsView {
    
    //    private var imageSection : some View {
    //
    //
    //
    //
    //
    //
    //    }
    
    private var pickerSection : some View {
        Picker(selection: $selectedFilter, label: Text("Filter")) {
            Text("All").tag(FilterType.all)
            Text("Active").tag(FilterType.active)
            Text("Reserve").tag(FilterType.reserve)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top,10)
        .padding(.horizontal)
    }
}
